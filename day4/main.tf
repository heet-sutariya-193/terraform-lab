terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

module "nginx_container_1" {
  source = "./modules/nginx_container"

  container_name = "nginx-module-1"
  host_port      = 8081
}

module "nginx_container_2" {
  source = "./modules/nginx_container"

  container_name = "nginx-module-2"
  host_port      = 8082
}
