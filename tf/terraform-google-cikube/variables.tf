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

variable "boot_disk_size" {
  description = "Size of the boot disk for agent machines"
  type        = number
}

variable "boot_disk_type" {
  description = "Type of the boot disk for agent machines"
  type        = string
}

variable "ssd_count" {
  description = "Number of local SSD disks to attach to each agent machine"
  type        = number
}

variable "scaler_cooldown_period" {
  description = "Cooldown period for the MIG's autoscaler in seconds"
  type        = number
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
