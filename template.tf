resource "aws_launch_configuration" "one" {
  image_id        = "ami-02d7fd1c2af6eead0"
  instance_type   = "t2.micro"
  key_name        = "hari"
  security_groups = [aws_security_group.mysg.id]
  user_data       = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl start httpd
    sudo systemctl enable httpd
    sudo systemctl restart httpd
    sudo chmod 766 /var/www/html/index.html
    sudo echo "<html><body><h1>welcome to terraform </h1><body></html>" >/var/www/html/index.html
    EOF
}

resource "aws_elb" "myelb" {
  name            = "terraform-1b"
  security_groups = [aws_security_group.mysg.id]
  subnets         = [aws_subnet.mysubnet1.id, aws_subnet.mysubnet2.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  tags = {
    Name = "terraform-lb"
  }
}

resource "aws_autoscaling_group" "two" {
  name                 = "my-asg"
  launch_configuration = aws_launch_configuration.one.name
  min_size             = 2
  max_size             = 3
  desired_capacity     = 2
  load_balancers       = [aws_elb.myelb.name]
  vpc_zone_identifier  = [aws_subnet.mysubnet1.id, aws_subnet.mysubnet2.id]
}

