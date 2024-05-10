resource "google_service_account" "this" {
  account_id   = "cikube-${var.cluster_name}-server"
  display_name = "Service Account for cikube server"
}

resource "google_compute_instance_template" "this" {
  name         = "cikube-${var.cluster_name}-server"
  description  = "This template is used to create a new cikube server node"

  region       = var.region
  machine_type = var.machine_type

  disk {
    auto_delete  = true
    boot         = true
    disk_size_gb = 25
    disk_type    = "pd-ssd"
    source_image = var.image
  }

  network_interface {
    network = var.network
    subnetwork = var.subnetwork

    dynamic "access_config" {
      for_each = var.external_ip_enabled ? [1] : []
      content {}
    }
  }

  service_account {
    email  = google_service_account.this.email
    scopes = ["cloud-platform"]
  }

  metadata = {
    startup-script = <<-EOF
      if [ ! -f /var/run/cikube_bootstrapped ]; then
        /usr/local/bin/cikube-init --role server --token ${var.token} --provider google --config-destination ${google_storage_bucket.this.name}
        touch /var/run/cikube_bootstrapped
      fi
    EOF
  }

  tags = concat(["cikube", "cikube-server", "cikube-${var.cluster_name}"], var.tags)
}

resource "google_compute_instance_from_template" "this" {
  name    = "cikube-${var.cluster_name}-server"
  zone    = var.zone

  source_instance_template = google_compute_instance_template.this.self_link
}

resource "random_id" "this" {
  byte_length = 2
}

resource "google_storage_bucket" "this" {
  name          = "cikube-${var.cluster_name}-server-${random_id.this.hex}"
  location      = var.region
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "this" {
  bucket = google_storage_bucket.server.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.this.email}"
}

resource "null_resource" "wait_for_kubeconfig" {
  provisioner "local-exec" {
    command = "until gsutil cat ${google_storage_bucket.this.name}/root_kubeconfig.yaml; do sleep 5; done"
  }
}

data "google_storage_bucket_object_content" "kubeconfig" {
  name       = "root_kubeconfig.yaml"
  bucket     = google_storage_bucket.this.name

  depends_on = [null_resource.wait_for_kubeconfig]
}
