output "file_path" {
  description = "Path of the created file"
  value       = local_file.hello.filename
}

output "file_content" {
  description = "Content of the created file"
  value       = local_file.hello.content
}
