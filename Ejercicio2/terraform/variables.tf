variable "aws_region" {
    description = "This is the AWS region to deploy our resorces in"
    type        = string
    default     = "us-east-1"
}

variable "key_name" {
    description = "Name of the Key Pair"
    type        = string
    default     = "myapp-key-pair.pem"
}

variable "ami_id" {
    description = "The AMI ID for the EC2 instance to be created"
    type        = string
    default     = "ami-070e22549dc49c1b4"
}

variable "instance_type" {
    description = "The instance type for the EC2 instance"
    type        = string
    default     = "t2.micro"
}

variable "availability_zone" {
    description = "The Availability Zone for the subnet"
    type        = string
    default     = "us-east-1a"
}