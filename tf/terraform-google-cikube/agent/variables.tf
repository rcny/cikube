variable "ssd_count" {
  description = "Number of local SSD disks to attach"
  type        = number
  default     = 2
}

variable "boot_disk_size" {
  description = "Size of the boot disk"
  type        = number
  default     = 20
}

variable "boot_disk_type" {
  description = "Type of the boot disk"
  type        = string
  default     = "pd-ssd"
}

variable "cluster_name" {
  description = "Name of the cikube cluster"
  type        = string
}

variable "agent_pool" {
  description = "Name of the agent pool"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the agent instances"
  type        = string
}

variable "region" {
  description = "GCP region for the instance template and autoscaler"
  type        = string
}

variable "zones" {
  description = "Actual GCP zones to deploy agents in"
  type        = list(string)
}

variable "image" {
  description = "Source image for the agent template"
  type        = string
}

variable "spot" {
  description = "Whether to use spot instances"
  type        = bool
  default     = false
}

variable "token" {
  description = "Token for cikube-init"
  type        = string
}

variable "server_ip" {
  description = "IP address of the cikube server"
  type        = string
}

variable "server_bucket_name" {
  description = "Name of the server bucket"
  type        = string
}

variable "opts" {
  description = "Additional options for the cikube-init"
  type        = string
}

variable "network" {
  description = "VPC network to deploy agents in"
  type        = string
}

variable "subnetwork" {
  description = "VPC subnetwork to deploy agents in"
  type        = string
  default     = null
}

variable "external_ip_enabled" {
  description = "Whether to use external IP address for the agent instances"
  type        = bool
  default     = true
}

variable "tags" {
  description = "List of custom tags to apply to the agent instances"
  type        = list(string)
  default     = []
}

variable "scaler_cpu_utilization" {
  description = "Target CPU utilization for the autoscaler"
  type        = number
  default     = 0.5
}

variable "scaler_predictive" {
  description = "Whether to use predictive autoscaling"
  type        = bool
  default     = true
}

variable "scaler_min_replicas" {
  description = "Minimum number of agents in the pool"
  type        = number
  default     = 0
}

variable "scaler_max_replicas" {
  description = "Maximum number of agents in the pool"
  type        = number
  default     = 10
}

variable "scaler_cooldown_period" {
  description = "Cooldown period for the autoscaler"
  type        = number
  default     = 240
}
