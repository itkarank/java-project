# VPC

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
}

# Public Subnet - 1

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = var.public_subnet_az
}

# Public Subnet - 2

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet2_cidr
  availability_zone = var.public_subnet2_az
}

# Internet Gateway

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Route Table for  Subnet

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.my_vpc.id
route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_igw.id
}
}

# Route Table for  Subnet2

resource "aws_route_table" "route_table2" {
  vpc_id = aws_vpc.my_vpc.id
route {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my_igw.id
}
}

# Route Table Association for  Subnet

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table.id
}

# Route Table Association for  Subnet

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.route_table2.id
}

