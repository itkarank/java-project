# Security Group for EC2 Instance


  resource "aws_security_group" "instance_sg" {
  vpc_id =  aws_vpc.my_vpc.id
  name        = "instance_sg"
  description = "Security group for the EC2 instance"

  ingress {
    from_port = 22   # for ansible
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [var.allowed_ip]
  }

  ingress {
    from_port = 80    # for web sever
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [var.allowed_ip]
  }

  ingress {
    from_port = 8080    # for jenkins
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = [var.allowed_ip]
  }

  ingress {
    from_port = 3000    # for docker conatiner
    to_port   = 3000
    protocol  = "tcp"
    cidr_blocks = [var.allowed_ip]
  }


  ingress {
    from_port = 8070    # for docker conatiner
    to_port   = 8070
    protocol  = "tcp"
    cidr_blocks = [var.allowed_ip]
  }

ingress {
    from_port = 9000   # for sonarqube
    to_port   = 9000
    protocol  = "tcp"
    cidr_blocks = [var.allowed_ip]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [var.allowed_ip]
  }
}

