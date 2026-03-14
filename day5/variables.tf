variable "filename" {
  description = "Name of the file"
  type        = string
  default     = "test.txt"
}

variable "message" {
  description = "Content of the file"
  type        = string
  default     = "Hello from CI/CD!"
}
