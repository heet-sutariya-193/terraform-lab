output "container_id" {
  description = "ID of the container"
  value       = docker_container.nginx.id
}

output "container_name" {
  description = "Name of the container"
  value       = docker_container.nginx.name
}

output "service_url" {
  description = "URL to access nginx"
  value       = "http://localhost:${var.host_port}"
}
