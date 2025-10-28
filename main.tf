provider "aws" {
  region = "eu-west-2"
}

# Key Pair
resource "aws_key_pair" "flask_key" {
  key_name   = "demo-key"
  public_key = file("terraform-flask.pub")
}

# Security Group
resource "aws_security_group" "flask_sg" {
  name        = "flask-sg"
  description = "Allow Flask access"

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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

# EC2 Instance
resource "aws_instance" "terraform-flask" {
  ami             = "ami-06a8ca19af7f6f3f4"
  instance_type   = "t2.micro"
  key_name        = "demo-key"
  security_groups = ["launch-wizard-1"]

  tags = {
    Name = "Flask-Docker"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install docker -y
              sudo service docker start
              sudo usermod -a -G docker ec2-user
              docker run -d -p 5000:5000 $${flask-app:latest}
              EOF
}