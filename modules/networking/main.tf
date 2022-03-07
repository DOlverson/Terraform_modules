resource "aws_vpc" "myvpc" {
  cidr_block           = var.my_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "mygateway" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "${var.env}-igw"
  }

}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.subnet_cidr
  tags = {
    Name = "${var.env}-public-subnet"
  }

}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygateway.id
  }
  tags = {
    Name = "${var.env}-route-table"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id

}

resource "aws_security_group" "ssh_access" {
  name        = "SSH"
  description = "Allow SSH"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "SSH access"
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

  tags = {
    Name = "${var.env}-allow-ssh"
  }
}