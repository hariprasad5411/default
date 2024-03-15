resource "aws_subnet" "mysubnet1" {
  vpc_id           = aws_vpc.myvpc.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "my-subnet-1"
  }
  cidr_block             = "10.0.1.0/25"
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "mysubnet2" {
  vpc_id           = aws_vpc.myvpc.id
  availability_zone = "us-east-1b"
  tags = {
    Name = "my-subnet-2"
  }
  cidr_block             = "10.0.2.0/25"
  map_public_ip_on_launch = "true"
}
