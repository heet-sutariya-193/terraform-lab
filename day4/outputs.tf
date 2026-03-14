output "container_1_info" {
  description = "Information about first container"
  value = {
    name = module.nginx_container_1.container_name
    url  = module.nginx_container_1.service_url
  }
}

output "container_2_info" {
  description = "Information about second container"
  value = {
    name = module.nginx_container_2.container_name
    url  = module.nginx_container_2.service_url
  }
}

output "all_urls" {
  description = "All service URLs"
  value = [
    module.nginx_container_1.service_url,
    module.nginx_container_2.service_url
  ]
}
