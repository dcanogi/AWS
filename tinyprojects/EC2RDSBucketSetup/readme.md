# Guide to Create AWS Resources with AWS CLI 🚀

[🔗 Spanish Version 🌍🇪🇸](spanish.md)

This document explains the steps to create a security group, an EC2 instance, an RDS database, and an S3 bucket in AWS using the AWS CLI.

![Diagrama](diagram.png)

## 1. Create a Security Group for EC2 🔐
First, we create a security group for the EC2 instance.

```bash
aws ec2 create-security-group --group-name ec2-security-group --description "Security group for EC2" --region us-east-1
```

## 2. Authorize Port 22 (SSH) and 80 (HTTP) in the Security Group 🌐
Now, we authorize access to ports 22 (for SSH) and 80 (for HTTP) in the security group we just created.

```bash
SECURITY_GROUP_ID=$(aws ec2 describe-security-groups --group-names ec2-security-group --query 'SecurityGroups[0].GroupId' --output text --region us-east-1)
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 22 --cidr 0.0.0.0/0 --region us-east-1
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 80 --cidr 0.0.0.0/0 --region us-east-1
```

## 3. Create the EC2 Instance 💻
Now, we create the EC2 instance. Make sure you have the AMI ID (`ami-0c55b159cbfafe1f0` as an example) and the SSH key you will use to access the instance.

```bash
aws ec2 run-instances --image-id ami-0c55b159cbfafe1f0 --count 1 --instance-type t2.micro --key-name my-aws-key --security-group-ids $SECURITY_GROUP_ID --query 'Instances[0].InstanceId' --output text --region us-east-1
```

## 4. Get the Public IP Address of the EC2 Instance 🌍
Once the instance is running, we get its public IP address.

```bash
aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text --region us-east-1
```

## 5. Create an RDS Database 🗄️
Now, let's create an RDS MySQL database. In this case, we will use the database name `mydb` and the provided username and password.

```bash
aws rds create-db-instance \
  --db-instance-identifier mydb-instance \
  --db-name mydb \
  --allocated-storage 20 \
  --db-instance-class db.t2.micro \
  --engine mysql \
  --master-username admin \
  --master-user-password mypassword123 \
  --backup-retention-period 7 \
  --no-multi-az \
  --publicly-accessible \
  --region us-east-1
```

## 6. Create an S3 Bucket 🗃️
We create an S3 bucket named `s3test`.

```bash
aws s3api create-bucket --bucket s3test --region us-east-1 --create-bucket-configuration LocationConstraint=us-east-1
```

## 7. Upload a Test File to the S3 Bucket 📂
We upload a test file named `test_file.txt` to the S3 bucket.

```bash
echo "This is a test file for S3" > test_file.txt
aws s3 cp test_file.txt s3://s3test/
```
