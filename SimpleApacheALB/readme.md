# 🌐 High Availability Web with Apache and ALB

This project implements a basic high-availability architecture using EC2, Apache, and an Application Load Balancer (ALB) on AWS.

## ✅ Architecture Overview

- Custom VPC with 2 public subnets in different AZs
- 2 EC2 instances with Apache installed, each serving different content
- Security Group allowing HTTP and SSH
- Application Load Balancer listening on port 80
- Health checks for availability
- Verified traffic distribution using `curl`

---

## 🧪 Expected Output

When accessing the Load Balancer URL, the response alternates between:

curl http://apachealb-1545250601.us-east-1.elb.amazonaws.com/


StatusCode        : 200
StatusDescription : OK
Content           : <html>Apache 1</html>

RawContent        : HTTP/1.1 200 OK
                    Connection: keep-alive
                    Upgrade: h2,h2c
                    Accept-Ranges: bytes
                    Content-Length: 22
                    Content-Type: text/html; charset=UTF-8
                    Date: Sun, 01 Jun 2025 20:18:27 GMT
                    ETag: "16-63687f8175391...
Forms             : {}
Headers           : {[Connection, keep-alive], [Upgrade, h2,h2c], [Accept-Ranges, bytes], [Content-Length, 22]...}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 22



curl http://apachealb-1545250601.us-east-1.elb.amazonaws.com/


StatusCode        : 200
StatusDescription : OK
Content           : <html>Apache 2</html>

RawContent        : HTTP/1.1 200 OK
                    Connection: keep-alive
                    Upgrade: h2,h2c
                    Accept-Ranges: bytes
                    Content-Length: 22
                    Content-Type: text/html; charset=UTF-8
                    Date: Sun, 01 Jun 2025 20:18:30 GMT
                    ETag: "16-63688262e4ca6...
Forms             : {}
Headers           : {[Connection, keep-alive], [Upgrade, h2,h2c], [Accept-Ranges, bytes], [Content-Length, 22]...}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : mshtml.HTMLDocumentClass
RawContentLength  : 22
