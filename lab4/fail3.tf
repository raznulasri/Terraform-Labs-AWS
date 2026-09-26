# .env
resource "local_file" "notes" {
  filename = "projek/.env"
  content  = "TOKEN=xxxyyyzzz"

  file_permission = "0644"
}