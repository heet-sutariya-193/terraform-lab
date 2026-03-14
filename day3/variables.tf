variable "container_name" {
  description = "Name of the Docker container"
  type        = string
  default     = "nginx-terraform"
}

variable "container_port" {
  description = "Port inside the container"
  type        = number
  default     = 80
}

variable "host_port" {
  description = "Port on the host machine"
  type        = number
  default     = 8080
}
