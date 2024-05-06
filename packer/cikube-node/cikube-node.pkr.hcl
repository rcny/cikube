locals {
  image_name_generic = "cikube-node-${var.image_version}"
  image_name_kernel6 = "${local.image_name_generic}-kernel6"
  image_name_kernel5 = "${local.image_name_generic}-kernel5"
}

source "googlecompute" "cikube" {
  project_id = var.gcloud_project_id
  subnetwork = var.gcloud_subnetwork
  tags       = var.gcloud_tags
  zone       = var.gcloud_zone

  machine_type = "c2d-highcpu-8"

  disable_default_service_account = true

  ssh_username = "packer"
  use_os_login = true

  skip_create_image = var.skip_create_image
}

build {
  name = "kernel6"

  source "source.googlecompute.cikube" {
    source_image        = "debian-12-bookworm-v20240213"
    image_name          = local.image_name_kernel6
    source_image_family = "cikube-node-kernel6"
  }

  provisioner "ansible" {
    galaxy_file   = "./ansible_requirements.yml"
    playbook_file = "./ansible_provision.yml"
    use_proxy     = false
  }
}

build {
  name = "kernel5"

  source "source.googlecompute.cikube" {
    source_image        = local.image_name_kernel6
    image_name          = local.image_name_kernel5
    source_image_family = "cikube-node-kernel5"
  }

  provisioner "ansible" {
    galaxy_file   = "./ansible_requirements.yml"
    playbook_file = "./ansible_provision_kernel5.yml"
    use_proxy     = false
  }
}
