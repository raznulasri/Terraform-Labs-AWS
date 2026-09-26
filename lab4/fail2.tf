# metadata.txt
resource "local_file" "config" {
  filename = "projek/metadata.txt"
  content  = <<-EOT
    app_name=terraform-demo
    version=1.0.0
    environment=development
  EOT

  file_permission = "0644"
}