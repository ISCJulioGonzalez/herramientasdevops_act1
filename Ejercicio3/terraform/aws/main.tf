provider "aws" {
  region = var.aws_region
}

resource "tls_private_key" "myapp_key" {
    algorithm   = "RSA"
    rsa_bits    = 2048
}

resource "aws_key_pair" "myapp_key_pair" {
    key_name    = var.key_name
    public_key  = tls_private_key.myapp_key.public_key_openssh
}

resource "local_file" "private_key" {
    filename        = "${path.module}/${var.key_name}"
    content         = tls_private_key.myapp_key.private_key_pem
    file_permission = "0400"
}

resource "aws_security_group" "myapp_sg" {
    name        = "myapp-sg"
    description = "Allow SSH and HTTP Access"

    ingress{
        description = "Allow SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress{
        description = "Allow HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }    

    ingress{
        description = "Allow HTTPS"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "myapp security group for Nginx and NodeJS web server"
    }
}

data "aws_vpc" "default" {
    default = true
}

data "aws_subnet" "default_subnet" {
    vpc_id            = data.aws_vpc.default.id
    availability_zone = var.availability_zone
}

resource "aws_instance" "myNginxNodeJS" {
    ami             = var.ami_id
    instance_type   = var.instance_type
    key_name        = aws_key_pair.myapp_key_pair.key_name

    vpc_security_group_ids  = [aws_security_group.myapp_sg.id]
    subnet_id               = data.aws_subnet.default_subnet.id

    tags = {
        Name = "DMDNginxServer"
    }
}