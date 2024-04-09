variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  default     = "10.0.1.0/24"
}

variable "public_subnet2_cidr" {
  description = "CIDR block for private subnet"
  default     = "10.0.2.0/24"
}

variable "public_subnet_az" {
  description = "Availability zone for public subnet"
  default     = "us-east-1a"
}

variable "public_subnet2_az" {
  description = "Availability zone for private subnet"
  default     = "us-east-1b"
}

variable "ami" {
  description = "Amazon Machine Image (AMI) ID for EC2 instance"
  default     = "ami-0440d3b780d96b29d"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.medium"
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  default     = "newkey"
}

variable "allowed_ip" {
  description = "Allowed IP address for SSH access"
  default     = "0.0.0.0/0"
}
