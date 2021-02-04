# NETWORK

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block_range
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Environment = var.environment_tag
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Environment = var.environment_tag
  }
}

resource "aws_subnet" "subnet_public_one" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_subnet_one
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone_one
  tags = {
    Environment = var.environment_tag
    Type = "Public"
  }
}

resource "aws_subnet" "subnet_public_two" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_subnet_two
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone_two
  tags = {
    Environment = var.environment_tag
    Type = "Public"
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Environment = var.environment_tag
  }
}

resource "aws_route_table_association" "rta_subnet_public_one" {
  subnet_id      = aws_subnet.subnet_public_one.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table_association" "rta_subnet_public_two" {
  subnet_id      = aws_subnet.subnet_public_two.id
  route_table_id = aws_route_table.rtb_public.id
}

# SECURITY GROUP

resource "aws_security_group" "sg_22" {
  name = "sg_22"
  vpc_id = aws_vpc.vpc.id
  ingress {
    description = "SSH from any IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
  description = "HTTPS"
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
    Environment = var.environment_tag
  }
}

# EC2 INSTANCE

resource "aws_instance" "test-instance_one" {
  ami = var.instance_ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.subnet_public_one.id
  vpc_security_group_ids = [aws_security_group.sg_22.id]
  key_name = "testing"
 tags = {
  Environment = var.environment_tag
 }
}

resource "aws_instance" "test-instance_two" {
  ami = var.instance_ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.subnet_public_two.id
  vpc_security_group_ids = [aws_security_group.sg_22.id]
  key_name = "testing"
 tags = {
  Environment = var.environment_tag
 }
}

# LOAD BALANCER

resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_22.id]
  subnets            = [
    aws_subnet.subnet_public_one.id,
    aws_subnet.subnet_public_two.id,
    ]

  enable_deletion_protection = false

  // access_logs {
  //   bucket  = aws_s3_bucket.lb_logs.bucket
  //   prefix  = "test-lb"
  //   enabled = true
  // }

  tags = {
    Environment = var.environment_tag
  }
}
