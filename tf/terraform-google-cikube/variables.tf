variable "cluster_name" {
  description = "The name of the cikube cluster"
  type        = string
}

variable "network" {
  description = "The cluster's network"
  type        = string
}

variable "subnetwork" {
  description = "The cluster's subnetwork"
  type        = string
}

variable "server_zone" {
  description = "The region's zone where the server machine will be deployed"
  type        = string
}

variable "server_tags" {
  description = "The additional tags to add to the server machine"
  type        = list(string)
  default     = []
}
variable "server_image" {
  description = "The cikube image reference for the server machine"
  type        = string
}

variable "server_zone" {
  description = "The zone where the server machine will be deployed"
  type        = string
}
variable "server_machine_type" {
  description = "The machine type for the server machine"
  type        = string
}

variable "server_external_ip_enabled" {
  description = "Whether to use external IP address for the server machine"
  type        = bool
  default     = true
}

variable "region" {
  description = "The region where all resources will be created"
  type        = string
}

variable "agent_pools" {
  description = "The cluster's agent pools to create"
  type = map(object({
    boot_disk_size         = number
    boot_disk_type         = string
    image                  = string
    machine_type           = string
    external_ip_enabled    = bool
    opts                   = string
    scaler_cooldown_period = number
    scaler_cpu_utilization = number
    scaler_max_replicas    = number
    scaler_min_replicas    = number
    scaler_predictive      = bool
    spot                   = bool
    ssd_count              = number
    tags                   = list(string)
    zones                  = list(string)
  }))
}
