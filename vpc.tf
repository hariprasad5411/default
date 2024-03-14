provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "one" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "two" {
  vpc_id = aws_vpc.one.id
  tags = {
    Name = "public-subnet"
  }
  cidr_block              = "10.0.1.0/24"
  availability_zone        = "us-east-1a"
  map_public_ip_on_launch = "true"
}
resource "aws_internet_gateway" "three" {
  vpc_id = aws_vpc.one.id
  tags = {
    Name = "my-gateway"
  }
}

resource "aws_route_table" "four" {
  tags = {
    Name = "my-route"
  }
  vpc_id = aws_vpc.one.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.three.id
  }
}
