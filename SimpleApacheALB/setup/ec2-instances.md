# 🖥️ EC2 Instances

## Apache 1

- Name: `Apache1`
- AMI: Amazon Linux 2
- Type: `t3.micro`
- Subnet: `Subnet-Apache1`
- Public IP: Enabled
- SG: `ApacheSG`

## Apache 2

- Name: `Apache2`
- AMI: Amazon Linux 2
- Type: `t3.micro`
- Subnet: `Subnet-Apache2`
- Public IP: Enabled
- SG: `ApacheSG`

## Access

- EC2 Instance Connect (no SSH key needed)
- Port 22 must be open in SG during setup
