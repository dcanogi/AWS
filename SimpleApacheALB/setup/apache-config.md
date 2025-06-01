# 🔧 Apache Configuration on EC2

Connect to each instance and run:

```bash
sudo su
yum -y update
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "<html>Apache 1</html>" > /var/www/html/index.html  # On Apache1
echo "<html>Apache 2</html>" > /var/www/html/index.html  # On Apache2
systemctl restart httpd
