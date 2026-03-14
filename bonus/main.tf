terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

# Pull nginx image once (can be reused)
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Create containers dynamically using count
resource "docker_container" "nginx" {
  count = length(var.container_config)
  
  image = docker_image.nginx.image_id
  name  = var.container_config[count.index].name

  ports {
    internal = 80
    external = var.container_config[count.index].port
  }
}

# Alternative: Using for_each (commented out)
/*
resource "docker_container" "nginx_for_each" {
  for_each = { for idx, config in var.container_config : config.name => config }
  
  image = docker_image.nginx.image_id
  name  = each.value.name

  ports {
    internal = 80
    external = each.value.port
  }
}
*/
