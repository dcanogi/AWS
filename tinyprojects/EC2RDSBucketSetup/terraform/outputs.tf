output "ec2_instance_id" {
  value = aws_instance.my_ec2.id
}

output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.my_db.endpoint
}

output "s3_bucket_name" {
  value = aws_s3_bucket.my_s3.bucket
}
