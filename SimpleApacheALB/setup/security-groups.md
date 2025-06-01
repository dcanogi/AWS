# 🔐 Security Groups

## ApacheSG (for EC2 instances)

- Inbound Rules:
  - TCP 22 (SSH) from `0.0.0.0/0` (for setup only)
  - TCP 80 (HTTP) from `0.0.0.0/0`
- Outbound:
  - All traffic allowed

## ApacheALBSG (for ALB)

- Inbound Rules:
  - TCP 80 (HTTP) from `0.0.0.0/0`
- Outbound:
  - TCP 80 (HTTP) to instances in ApacheSG (or all traffic allowed)

## Note:
- Make sure the target EC2 instances allow incoming traffic from the ALB (i.e., ApacheSG allows traffic from ApacheALBSG).
