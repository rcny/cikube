resource "random_password" "token" {
  length  = 48
  special = false
}

module "server" {
  source = "./server"

  cluster_name = var.cluster_name
  image        = var.server_image
  machine_type = var.server_machine_type
  network      = var.network
  external_ip_enabled = var.server_external_ip_enabled
  region       = var.region
  subnetwork   = var.subnetwork
  tags         = var.server_tags
  token        = random_password.token.result
  zone         = var.server_zone
}

module "agent" {
  source   = "./agent"
  for_each = var.agent_pools

  agent_pool             = each.key
  boot_disk_size         = each.value.boot_disk_size
  boot_disk_type         = each.value.boot_disk_type
  cluster_name           = var.cluster_name
  image                  = each.value.image
  machine_type           = each.value.machine_type
  network                = var.network
  external_ip_enabled    = each.external_ip_enabled
  opts                   = each.value.opts
  region                 = var.region
  scaler_cooldown_period = each.value.scaler_cooldown_period
  scaler_cpu_utilization = each.value.scaler_cpu_utilization
  scaler_max_replicas    = each.value.scaler_max_replicas
  scaler_min_replicas    = each.value.scaler_min_replicas
  scaler_predictive      = each.value.scaler_predictive
  server_ip              = module.server.network_interface[0].network_ip
  spot                   = each.value.spot
  ssd_count              = each.value.ssd_count
  subnetwork             = var.subnetwork
  tags                   = each.value.tags
  token                  = random_password.token.result
  zones                  = each.value.zones
}
