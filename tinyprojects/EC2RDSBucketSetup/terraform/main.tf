provider "aws" {
  region = var.region
}

resource "aws_security_group" "my_sec_group" {
  name        = var.security_group_name
  description = "Security group for EC2"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_key_pair" "my_key" {
  key_name   = var.key_name
  public_key = file("${path.module}/my-key.pub")
}

resource "aws_instance" "my_ec2" {
  ami           = data.aws_ami.latest_ami.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_sec_group.name]
  subnet_id     = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "MyEC2Instance"
  }
}

resource "aws_db_instance" "my_db" {
  allocated_storage    = 20
  db_instance_class   = "db.t3.micro"
  engine               = "mysql"
  master_username      = var.db_username
  master_password      = var.db_password
  db_name              = var.db_name
  backup_retention_period = 7
  publicly_accessible  = true
}

resource "aws_s3_bucket" "my_s3" {
  bucket = var.s3_bucket_name
  acl    = "private"
}

data "aws_ami" "latest_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
