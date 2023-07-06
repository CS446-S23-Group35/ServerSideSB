resource "aws_vpc" "backend_vpc" {
 cidr_block = var.vpc_cidr
 enable_dns_hostnames = true
 
 tags = {
   Name = "VPC"
 }
}

###########
# Subnets #
###########

resource "aws_subnet" "public_sub" {
  vpc_id     = aws_vpc.backend_vpc.id
  cidr_block = var.public_subnet_cidr
  
  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private_sub" {
  vpc_id     = aws_vpc.backend_vpc.id
  cidr_block = var.private_subnet_cidrs
  
  tags = {
    Name = "Private Subnet"
  }
}

###########################
# Gateway and Route Table #
###########################

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.backend_vpc.id
 
  tags = {
    Name = "VPC Internet Gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.backend_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Internet Route Table"
  }
}

resource "aws_route_table_association" "public_subnet_asso" {
 subnet_id      = aws_subnet.public_sub.id
 route_table_id = aws_route_table.public_rt.id
}

##########################
# Bastion Security Group #
##########################

resource "aws_security_group" "bastion_sg" {
  name        = "Bastion Security Group"
  description = "Bastion Security Group"
  vpc_id      = aws_vpc.backend_vpc.id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
