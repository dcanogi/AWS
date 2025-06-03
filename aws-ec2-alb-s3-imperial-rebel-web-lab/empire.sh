#!/bin/bash
yum -y update
yum install -y httpd
systemctl start httpd
systemctl enable httpd
curl http://169.254.169.254/latest/meta-data/hostname > /tmp/hostname
echo "<html><body style='background-color:black; color:yellow; background-image:url(https://wallpapercave.com/wp/wp6609736.jpg); background-size:cover;'>
<h1 style='text-align:center;'>🌌 EC2 of the Empire 🌌</h1>
<img src='https://bucket893457935248.s3.us-east-1.amazonaws.com/aws.png' style='display:block; margin:auto; width:200px;'/>
</body></html>" > /var/www/html/index.html
systemctl restart httpd
