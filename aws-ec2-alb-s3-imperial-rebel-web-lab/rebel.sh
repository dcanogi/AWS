#!/bin/bash
yum -y update
yum install -y httpd
systemctl start httpd
systemctl enable httpd
curl http://169.254.169.254/latest/meta-data/hostname > /tmp/hostname
echo "<html><body style='background-color:#1a1a1a; color:white; background-image:url(https://wallpaperaccess.com/full/4711398.jpg); background-size:cover;'>
<h1 style='text-align:center;'>✨ Rebel EC2 Node ✨</h1>
</body></html>" > /var/www/html/index.html
systemctl restart httpd
