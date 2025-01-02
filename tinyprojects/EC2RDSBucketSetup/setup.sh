#!/bin/bash

# Variables
REGION="us-east-1"            # AWS Region (N. Virginia)
AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" --query "Images | sort_by(@, &CreationDate) | [-1].ImageId" --output text --region $REGION)
INSTANCE_TYPE="t2.micro"
KEY_NAME="my-key-pair"
SECURITY_GROUP_NAME="my-sec-group"
DB_NAME="mydatabase"
DB_INSTANCE_IDENTIFIER="mydb-instance"
DB_USERNAME="admin"
DB_PASSWORD="yourpassword123"
S3_BUCKET_NAME="my-s3-bucket-$(date +%Y%m%d)"

# Step 1: Get the ID of the default VPC subnet
SUBNET_ID=$(aws ec2 describe-subnets --filters Name=vpc-id,Values=$(aws ec2 describe-vpcs --query "Vpcs[?IsDefault==\`true\`].VpcId" --output text --region $REGION) --query 'Subnets[0].SubnetId' --output text --region $REGION)
echo "Subnet ID obtained: $SUBNET_ID"

# Step 2: Create security group if it doesn't exist
  SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name $SECURITY_GROUP_NAME --description "Security group for EC2" --region $REGION --query 'GroupId' --output text)
  aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 22 --cidr 0.0.0.0/0 --region $REGION
  aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 80 --cidr 0.0.0.0/0 --region $REGION
  echo "Security group $SECURITY_GROUP_NAME created with ID: $SECURITY_GROUP_ID"

# Step 3: Create key pair if it doesn't exist
if ! aws ec2 describe-key-pairs --key-name $KEY_NAME --region $REGION &> /dev/null; then
  aws ec2 create-key-pair --key-name $KEY_NAME --query 'KeyMaterial' --output text --region $REGION > ${KEY_NAME}.pem
  chmod 400 ${KEY_NAME}.pem
  echo "Key pair $KEY_NAME created."
else
  echo "Key pair $KEY_NAME already exists."
fi

# Step 4: Check if EC2 instance exists, if not, create it
INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=MyEC2Instance" --query 'Reservations[0].Instances[0].InstanceId' --output text --region $REGION)
if [ "$INSTANCE_ID" == "None" ]; then
  INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type $INSTANCE_TYPE --key-name $KEY_NAME --security-group-ids $SECURITY_GROUP_ID --subnet-id $SUBNET_ID --associate-public-ip-address --query 'Instances[0].InstanceId' --output text --region $REGION)
  echo "EC2 instance created with ID: $INSTANCE_ID"
else
  echo "EC2 instance already exists with ID: $INSTANCE_ID"
fi

# Step 5: Wait for the instance to be in 'running' state
aws ec2 wait instance-running --instance-ids $INSTANCE_ID --region $REGION
echo "EC2 instance is running."

# Step 6: Get the public IP of the EC2 instance
EC2_PUBLIC_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text --region $REGION)
if [ "$EC2_PUBLIC_IP" == "None" ]; then
  echo "Error: EC2 instance does not have a public IP."
  exit 1
fi
echo "EC2 public IP: $EC2_PUBLIC_IP"

# Step 7: Check if RDS instance exists, if not, create it
  aws rds create-db-instance \
    --db-instance-identifier $DB_INSTANCE_IDENTIFIER \
    --db-name $DB_NAME \
    --allocated-storage 20 \
    --db-instance-class db.t3.micro \
    --engine mysql \
    --master-username $DB_USERNAME \
    --master-user-password $DB_PASSWORD \
    --backup-retention-period 7 \
    --no-multi-az \
    --publicly-accessible \
    --region $REGION
  echo "RDS database instance created."

# Step 8: Wait for the RDS instance to be available
echo "RDS instance is starting..."
aws rds wait db-instance-available --db-instance-identifier $DB_INSTANCE_IDENTIFIER --region $REGION
echo "RDS instance is available."

# Step 9: Get the RDS database endpoint
RDS_ENDPOINT=$(aws rds describe-db-instances --db-instance-identifier $DB_INSTANCE_IDENTIFIER --query 'DBInstances[0].Endpoint.Address' --output text --region $REGION)
echo "RDS database endpoint: $RDS_ENDPOINT"

# Step 10: Check if the S3 bucket exists, if not, create it
BUCKET_EXISTS=$(aws s3api head-bucket --bucket $S3_BUCKET_NAME --region $REGION 2>&1)
  if [ "$REGION" == "us-east-1" ]; then
    aws s3api create-bucket --bucket $S3_BUCKET_NAME --region $REGION
  else
    aws s3api create-bucket --bucket $S3_BUCKET_NAME --region $REGION --create-bucket-configuration LocationConstraint=$REGION
  fi
  echo "S3 bucket created with name: $S3_BUCKET_NAME"

# -------------------------------
# Test steps
# -------------------------------

# Test S3 access
echo "Testing access to S3 bucket..." > test.txt
aws s3 cp test.txt s3://$S3_BUCKET_NAME/
echo "File uploaded to S3 bucket successfully."

# Test RDS connection
echo "Testing connection to RDS database..."
MYSQL_CMD="mysql -h $RDS_ENDPOINT -u $DB_USERNAME -p$DB_PASSWORD -e 'SHOW DATABASES;'"
if $MYSQL_CMD; then
  echo "RDS database connection successful."
else
  echo "Error connecting to RDS database."
fi

# -------------------------------
# Display resource details
# -------------------------------

echo "Details of the created resources:"
echo "EC2 Instance ID: $INSTANCE_ID"
echo "EC2 Public IP: $EC2_PUBLIC_IP"
echo "RDS Instance ID: $DB_INSTANCE_IDENTIFIER"
echo "S3 Bucket Name: $S3_BUCKET_NAME"
