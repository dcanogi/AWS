# ⚖️ Application Load Balancer (ALB)

- Name: `ApacheALB`
- Type: Internet-facing
- IP type: IPv4
- VPC: `ApacheVPC`
- SG: `ApacheALBSG`
- Subnets: `Subnet-Apache1`, `Subnet-Apache2`
- Listener: Port 80 (HTTP)

## Target Group

- Target type: Instance
- Protocol: HTTP
- Port: 80
- Registered targets: Apache1 and Apache2
- Health check: Path `/` (default)

## Result

The ALB routes traffic between both Apache instances.
