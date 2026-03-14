variable "filename" {
  description = "Name of the file to create"
  type        = string
  default     = "hello.txt"
}

variable "message" {
  description = "Message to write in the file"
  type        = string
  default     = "Hello from Terraform"
}
