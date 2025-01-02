variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "security_group_name" {
  description = "Security group name"
  default     = "my-sec-group"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "EC2 key pair name"
  default     = "my-key-pair"
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
}

variable "db_name" {
  description = "Database name"
  default     = "mydatabase"
}

variable "db_username" {
  description = "Database username"
  default     = "admin"
}

variable "db_password" {
  description = "Database password"
  default     = "yourpassword123"
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
  default     = "my-s3-bucket-$(date +%Y%m%d)"
}
