output "instance_template" {
  description = "The entire server instance template resource"
  value       = google_compute_instance_template.this
}

output "instance" {
  description = "The entire server instance resource"
  value       = google_compute_instance_from_template.this
}

output "kubeconfig" {
  description = "The admin kubeconfig for the cluster"
  value       = data.google_storage_bucket_object_content.kubeconfig.content
  sensitive   = true
}

output "bucket" {
  description = "The entire server GCS bucket resource"
  value       = google_storage_bucket.this
}
