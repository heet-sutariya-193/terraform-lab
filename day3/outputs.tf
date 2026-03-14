output "container_id" {
  description = "ID of the Docker container"
  value       = docker_container.nginx.id
}

output "container_name" {
  description = "Name of the Docker container"
  value       = docker_container.nginx.name
}

output "service_url" {
  description = "URL to access nginx"
  value       = "http://localhost:${var.host_port}"
}

output "network_info" {
  description = "Network information"
  value       = "Container running on port ${var.host_port}"
}
