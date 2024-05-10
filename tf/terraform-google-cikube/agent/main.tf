resource "null_resource" "wait_for_server" {
  provisioner "local-exec" {
    command = "until gcloud compute ssh ${var.server_ip} --region ${var.region} --network ${var.network} --command 'k3s kubectl get nodes'; do sleep 2; done"
  }
}

resource "google_compute_instance_template" "this" {
  name         = "cikube-${var.cluster_name}-agent-${var.agent_pool}"
  description  = "This template is used to create agents for the ${var.agent_pool} pool"

  machine_type = var.machine_type
  region       = var.region

  disk {
    auto_delete  = true
    boot         = true
    disk_size_gb = var.boot_disk_size
    disk_type    = var.boot_disk_type
    source_image = var.image
  }

  dynamic "disk" {
    for_each = range(var.ssd_count)
    content {
      type         = "SCRATCH"
      disk_type    = "local-ssd"
      disk_size_gb = 375
      interface    = "NVME"
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    dynamic "access_config" {
      for_each = var.external_ip_enabled ? [1] : []
      content {}
    }
  }

  scheduling {
    preemptible                 = var.spot
    automatic_restart           = var.spot ? false : true
    instance_termination_action = var.spot ? "DELETE" : null
    dynamic "provisioning_model" {
      for_each = var.spot ? ["SPOT"] : []
      content {
        provisioning_model = provisioning_model.value
      }
    }
    dynamic "max_run_duration" {
      for_each = var.spot ? [1] : []
      content {
        seconds = 43200 # 12 hours
      }
    }
  }

  metadata = {
    startup-script = <<-EOF
      if [ ! -f /var/run/cikube_bootstrapped ]; then
        /usr/local/bin/cikube-storage-ln --mount /mnt/local
        /usr/local/bin/cikube-init \
          --role agent \
          --token ${var.token} \
          --provider google \
          --opts "--server https://${var.server_ip}:6443 --kubelet-arg 'root-dir=/mnt/local/kubelet' ${var.opts}"
        touch /var/run/cikube_bootstrapped
      fi
    EOF
  }

  tags = concat(["cikube", "cikube-agent", "cikube-${var.cluster_name}", "cikube-${var.cluster_name}-${var.agent_pool}"], var.tags)
}

resource "google_compute_region_instance_group_manager" "this" {
  name = "cikube-${var.cluster_name}-agent-${var.agent_pool}"

  base_instance_name        = "cikube-${var.cluster_name}-agent-${var.agent_pool}"
  region                    = var.region

  distribution_policy_zones        = var.zones
  distribution_policy_target_shape = "BALANCED"

  update_policy {
    type                         = "PROACTIVE"
    minimal_action               = "REPLACE"
    instance_redistribution_type = "NONE"
  }

  version {
    instance_template = google_compute_instance_template.this.self_link
  }

  all_instances_config {
    labels = {
      cikube_cluster = var.cluster_name
    }
  }

  depends_on = [null_resource.wait_for_server]
}

resource "google_compute_region_autoscaler" "this" {
  name   = "cikube-${var.cluster_name}-agent-${var.agent_pool}"
  region = var.region
  target = google_compute_region_instance_group_manager.this.self_link

  autoscaling_policy {
    min_replicas    = var.scaler_min_replicas
    max_replicas    = var.scaler_max_replicas
    cooldown_period = var.scaler_cooldown_period

    cpu_utilization {
      target            = var.scaler_cpu_utilization
      predictive_method = var.scaler_predictive ? "OPTIMIZE_AVAILABILITY" : "NONE"
    }
  }
}
