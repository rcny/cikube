# common

variable "image_version" {
  type = string
  default = null
}

variable "skip_create_image" {
  type = bool
  default = false
}

# gcloud

variable "gcloud_project_id" {
  type = string
  default = null
}

variable "gcloud_subnetwork" {
  type = string
  default = null
}

variable "gcloud_tags" {
  type = list(string)
  default = []
}

variable "gcloud_zone" {
  type = string
  default = null
}
