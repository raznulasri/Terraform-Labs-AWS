# Raznul AWS Web Server Infrastructure (Terraform)

This project provisions an Nginx web server on AWS using Terraform, including AWS Systems Manager (SSM) access.
Please execute these commands on a local machine with configured AWS CLI access.

---

## 📐 Architecture Diagram


```text
                        +-------------------------------------------------------+
                        |                 AWS Cloud (ap-southeast-1)            |
                        +-------------------------------------------------------+
                                                    |
                                                    v
                        +-------------------------------------------------------+
                        | VPC: aws_vpc.main                                     |
                        | - Name: "raznul-vpc"                                  |
                        | - CIDR: 10.0.0.0/16                                   |
                        +-------------------------------------------------------+
                                                    |
                                                    v
                        +-------------------------------------------------------+
                        | Public Subnet: aws_subnet.public                      |
                        | - Name: "raznul-public-subnet"                        |
                        | - CIDR: 10.0.1.0/24                                   |
                        | - IGW Attachment: aws_internet_gateway.main           |
                        |   (Name: "raznul-igw")                                |
                        | - Route Table: aws_route_table.public                 |
                        |   (Name: "raznul-public-rt" | 0.0.0.0/0 -> IGW)        |
                        +-------------------------------------------------------+
                                                    |
                                                    v
+-----------------------------------+   +---------------------------------------+   +-----------------------------------+
| Security Group:                   |-->| EC2 Instance: aws_instance.web        |<--| IAM Instance Profile:             |
| aws_security_group.web            |   | - Name: "raznul-web-server"           |   | aws_iam_instance_profile.ec2_profile|
| - Name: "raznul-web-sg"           |   | - AMI: "ami-0532913178263be11"        |   | - Name: "raznul-ec2-ssm-profile"  |
|                                   |   | - Type: "t3.micro"                    |   +-----------------------------------+
| [Ingress Rules]                   |   | - Public IP: Auto-assigned            |                     ^
| - Port 80 (HTTP) from 0.0.0.0/0   |   |                                       |                     |
|                                   |   | [User Data Script]                    |   +-----------------------------------+
| [Egress Rules]                    |   | - apt update & install nginx          |   | IAM Role: aws_iam_role.ec2_ssm_role|
| - All Traffic (-1) to 0.0.0.0/0   |   | - systemctl start/enable nginx        |   | - Name: "instance_ssm_role"       |
+-----------------------------------+   | - echo "<h1>Raznul Terraform!</h1>"   |   | - Managed Policy Attachment:      |
                                        +---------------------------------------+   |   AmazonSSMManagedInstanceCore    |
                                                    |                               +-----------------------------------+
                                                    v
                        +-------------------------------------------------------+
                        | Outputs:                                              |
                        | - account_id          : data.aws_caller_identity.current|
                        | - caller_arn          : data.aws_caller_identity.arn    |
                        | - instance_public_ip  : aws_instance.web.public_ip   |
                        | - instance_id         : aws_instance.web.id           |
                        +-------------------------------------------------------+
```
