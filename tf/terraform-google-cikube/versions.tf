terraform {
  required_version = "~> 1.6"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.24"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}
