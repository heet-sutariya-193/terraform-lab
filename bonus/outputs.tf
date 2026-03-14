# Generate list of container URLs
output "container_urls" {
  description = "List of all container URLs"
  value = [for config in var.container_config : "http://localhost:${config.port}"]
}

# Detailed information about each container
output "container_details" {
  description = "Detailed information about each container"
  value = {
    for idx, container in docker_container.nginx :
    container.name => {
      id  = container.id
      url = "http://localhost:${var.container_config[idx].port}"
    }
  }
}

# Count of containers created
output "total_containers" {
  description = "Total number of containers created"
  value       = length(docker_container.nginx)
}
