
# Cipta Security Group
resource "aws_security_group" "web" {
  name        = "bootcamp-web-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    description = "All outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bootcamp-web-sg"
  }
}

# Cipta EC2
resource "aws_instance" "web" {
  ami           = "ami-0532913178263be11"  # Ganti dengan AMI ID anda
  instance_type = "t3.micro"

  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  tags = {
    Name = "bootcamp-web-server"
  }

## User data untuk web server
  user_data_replace_on_change = true
  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    DEBIAN_FRONTEND=noninteractive apt install -y nginx
    systemctl start nginx
    systemctl enable nginx
    echo "<h1>Raznul Terraform!</h1>" > /var/www/html/index.html
  EOF

## Kemaskini EC2 Instance
iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

}

# Tambah Output
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

output "instance_id" {
  value = aws_instance.web.id
}
