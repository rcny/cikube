output "name" {
  description = "The name of the cluster"
  value = var.cluster_name
}

output "token" {
  description = "The token used to join agents to the cluster"
  value     = random_password.token.result
  sensitive = true
}
