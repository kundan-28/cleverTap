resource "aws_security_group" "web" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "web_sg"
  }
}

resource "aws_launch_configuration" "wordpress" {
  name            = "wordpress-lc"
  image_id        = "ami-08c191625cfb7ee61"
  instance_type   = "t3.micro"
  security_groups = [aws_security_group.web.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              yum install httpd wget unzip vim -y
              systemctl start httpd
              systemctl enabled httpd
              mkdir -p /tmp/finance
              cd /tmp/finance
              wget https://www.tooplate.com/zip-templates/2135_mini_finance.zip
              unzip -o 2135_mini_finance.zip
              cp -r 2135_mini_finance/* /var/www/html/
              systemctl restart httpd
              cd /tmp/
              rm -rf /tmp/finance
              EOF
}


resource "aws_autoscaling_group" "wordpress" {
  desired_capacity     = 2
  max_size             = 4
  min_size             = 1
  vpc_zone_identifier  = [aws_subnet.public_a.id, aws_subnet.public_b.id] 
  launch_configuration = aws_launch_configuration.wordpress.id

  tag {
    key                 = "Name"
    value               = "wordpress-asg"
    propagate_at_launch = true
  }
}

resource "aws_elb" "wordpress" {
  name               = "wordpress-elb"
  subnets            = [aws_subnet.public_a.id, aws_subnet.public_b.id] 
  security_groups    = [aws_security_group.web.id]

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
    # ssl_certificate_id = aws_acm_certificate.main.arn
    # ssl_certificate_id = "arn:aws:acm:us-west-2:320871476719:certificate/4a15bc83-2c8d-4ad8-86bf-ba0af1e37fc7"
  }

  tags = {
    Name = "wordpress-elb"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.wordpress.name
  elb                    = aws_elb.wordpress.name
}
