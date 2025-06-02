# 🚀 AWS EC2 + ALB + Auto Scaling Lab 🛠️

## 🎯 Objective
Build a highly available web architecture on AWS using EC2, Auto Scaling Group (ASG), Application Load Balancer (ALB), and a VPC configured with public subnets.

## 🧩 Components used
- **💻 Amazon EC2:** t3.micro instances running Apache.
- **📈 Auto Scaling Group:** Maintains a minimum number of instances and scales based on demand.
- **🎛️ Application Load Balancer:** Distributes HTTP traffic among the instances.
- **🌐 VPC:** Private network with public subnets, Internet Gateway, and proper routing.
- **🔐 Security Groups:** Controls inbound HTTP access and outbound traffic.
- **📋 Launch Template:** Configuration to launch EC2 instances with User Data that installs Apache automatically.

## 🔨 Steps performed
1. Created a VPC with public subnets across two Availability Zones 🌍.
2. Configured an Internet Gateway and associated it with route tables 🔌.
3. Created a Launch Template with User Data to install and start Apache on boot 🛎️.
4. Set up an Auto Scaling Group with a minimum of 2 and maximum of 4 instances distributed across two zones ⚖️.
5. Created an Application Load Balancer and Target Groups pointing to the instances 🎯.
6. Adjusted Security Groups to allow incoming HTTP (port 80) and outbound traffic 🚦.
7. Verified healthy status in Target Groups ✅.
8. Debugged and resolved issues 🕵️‍♂️:
    - Enabled **Enable DNS hostnames** and **Enable DNS resolution** in the VPC to allow instances to resolve public DNS and download packages 🌐.

## ⚠️ Issues encountered and solution
- EC2 instances couldn’t access the internet or install Apache because DNS settings were disabled in the VPC 🚫.
- Enabling **Enable DNS hostnames** and **Enable DNS resolution** fixed the problem ✔️.

## 🎉 Result
A working AWS architecture with load balancing and auto scaling, where instances install Apache correctly and respond to HTTP requests 📡.

## 🔗 Links
Repository with code and configuration:  
https://github.com/dcanogi/AWS/tree/main/aws-ec2-alb-autoscaling-lab

## 📬 Contact
Feel free to reach out if you have questions or want to share your experience 💬.

---

# 🚀 Road to AWS Solutions Architect Associate
