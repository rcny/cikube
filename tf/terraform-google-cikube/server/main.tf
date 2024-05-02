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
  }

  metadata = {
    startup-script = <<-EOF
      if [ ! -f /var/run/cikube_bootstrapped ]; then
        /usr/local/bin/cikube-init --role server --token ${var.token}
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
