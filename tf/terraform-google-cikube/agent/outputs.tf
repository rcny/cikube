output "instance_template" {
  description = "The entire agent instance template resource"
  value       = google_compute_instance_template.this
}

output "instance_group_manager" {
  description = "The entire agent instance group manager resource"
  value       = google_compute_region_instance_group_manager.this
}

output "autoscaler" {
  description = "The entire agent autoscaler resource"
  value       = google_compute_region_autoscaler.this
}
