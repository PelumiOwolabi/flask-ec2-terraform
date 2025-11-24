provider "aws" {
  region = "eu-west-2"
}


# VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "flask-vpc"
  }
}

# PUBLIC SUBNET
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "flask-public-subnet"
  }
}


# INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "flask-igw"
  }
}

# ROUTE TABLE + ASSOCIATION
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "flask-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

# SECURITY GROUP
resource "aws_security_group" "flask_sg" {
  name        = "flask-sg"
  description = "Allow Flask + SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Flask app"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
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
    Name = "flask-sg"
  }
}

# KEY PAIR
resource "aws_key_pair" "flask_key" {
  key_name   = "flask-demo-key"
  public_key = file("${path.module}/keys/terraform-flask.pub")
}


# EC2 INSTANCE
resource "aws_instance" "flask_server" {
  ami                         = "ami-0eb260c4d5475b901" # Amazon Linux 2 (eu-west-2)
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true

  vpc_security_group_ids = [
    aws_security_group.flask_sg.id
  ]

  key_name = aws_key_pair.flask_key.key_name

  user_data = file("user_data.sh")

  tags = {
    Name = "Flask-Server"
  }
}
