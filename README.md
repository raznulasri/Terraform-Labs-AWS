## Architecture Diagram

```text
                       +----------------------------------------+
                       |             AWS Cloud                  |
                       +----------------------------------------+
                                       |
                                       v
                       +----------------------------------------+
                       |           VPC (aws_vpc.main.id)        |
                       +----------------------------------------+
                                       |
                                       v
                       +----------------------------------------+
                       |  Public Subnet (aws_subnet.public.id)  |
                       +----------------------------------------+
                                       |
                                       v
+-----------------------+   +----------------------------------+   +-------------------+
|   Security Group      |-->|        EC2 Instance (web)        |<--| IAM Instance      |
| "bootcamp-web-sg"     |   | AMI: ami-0532913178263be11       |   | Profile           |
|                       |   | Type: t3.micro                   |   | "ec2_profile"     |
| [Ingress]             |   |                                  |   +-------------------+
| Port 80 (HTTP)        |   | [User Data Script]               |
| From 0.0.0.0/0 (All)  |   | - Installs Nginx                 |
|                       |   | - Starts Nginx                   |
| [Egress]              |   | - Creates Hello World index.html |
| All Traffic           |   |                                  |
| To 0.0.0.0/0 (All)    |   +----------------------------------+
+-----------------------+           |                  |
                                     v                  v
                       +-----------------------+  +------------------+
                       | Output:               |  | Output:          |
                       | instance_public_ip    |  | instance_id      |
                       +-----------------------+  +------------------+
