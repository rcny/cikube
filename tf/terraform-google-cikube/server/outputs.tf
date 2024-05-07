output "instance_template" {
  description = "The entire server instance template resource"
  value       = google_compute_instance_template.this
}

output "instance" {
  description = "The entire server instance resource"
  value       = google_compute_instance_from_template.this
}
