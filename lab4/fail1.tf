# README.md
resource "local_file" "readme" {
  filename = "projek/README.md"
  content  = <<-EOT
    # Project Terraform Saya

    Projek ini dicipta menggunakan Terraform.

    ## Kandungan
    - README.md: Dokumentasi projek
    - metadata.txt: Informasi aplikasi
    - .env: Pembolehubah
  EOT

  file_permission = "0644"
}