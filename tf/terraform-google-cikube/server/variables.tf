variable "cluster_name" {
  description = "Name of the cikube cluster"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the server instance"
  type        = string
  default     = "c3d-highcpu-4"
}

variable "region" {
  description = "GCP region for the instance template (ephemeral)"
  type        = string
}

variable "image" {
  description = "Source image for the server template"
  type        = string
}

variable "network" {
  description = "VPC network to deploy server in"
  type        = string
}

variable "subnetwork" {
  description = "VPC subnetwork to deploy server in"
  type        = string
  default     = null
}

variable "token" {
  description = "Token for cikube-init"
  type        = string
  sensitive   = true
}

variable "zone" {
  description = "Actual GCP zone to deploy server in"
  type        = string
}

variable "external_ip_enabled" {
  description = "Whether to use external IP address for the server instance"
  type        = bool
  default     = true
}

variable "tags" {
  description = "List of custom tags to apply to the server instance"
  type        = list(string)
  default     = []
}
