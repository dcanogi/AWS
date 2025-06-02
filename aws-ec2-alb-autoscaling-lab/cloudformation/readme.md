# 🚀 Simple Apache Web Server on EC2 with CloudFormation

This CloudFormation template deploys a basic **Apache HTTP Server** on an **EC2 instance** inside a specified **VPC subnet**.

## 🌟 Features

- EC2 instance with Amazon Linux 2  
- Apache HTTP Server installed and started on boot  
- Default web page shows a friendly message including the EC2 hostname  
- UserData script handles installation and setup automatically  

## 📋 Usage

1. Deploy the CloudFormation stack in your AWS account.  
2. Specify the following parameters:  
   - `SubnetId`: The subnet where the EC2 will be launched.  
   - `InstanceType`: The EC2 instance type (e.g., t3.micro).  
   - `KeyName`: (Optional) SSH key pair name to access the instance.  
3. Once launched, find the public IP or DNS of the EC2 instance.  
4. Open a browser and navigate to the public IP or DNS to see the message:

Hello, this website is hosted by [hostname]

## ⚙️ Template Details

- Uses Amazon Linux 2 AMI in your region.  
- Runs a simple shell script on launch to install and start Apache.  
- Outputs the instance ID and public DNS for convenience.  

## 📂 Files

- `template.yaml`: CloudFormation template defining the EC2 and UserData.  
- `README.md`: This file.  

## 🧠 Learning Outcomes

- Basics of CloudFormation templates  
- How to pass UserData to EC2 instances  
- Automating Apache installation on EC2  
- Displaying dynamic info on the website via shell commands  
