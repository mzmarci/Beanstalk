locals {
  ports = [443, 80]
}


resource "aws_security_group" "elb_security_group" { // this secuirty group will be used for my instance profile
  name        = "stock_security_group"
  description = "Allow SSH, HTTP, and other connections"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.ports
    content {
      description = "Allow traffic on port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      security_groups = [aws_security_group.lb_security_group.id]  
    }
  }

  # Egress rule to allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # "-1" means all protocols
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic to any IP
  }

  tags = {
    Name = "elb security group"
  }
}

resource "aws_security_group" "lb_security_group" {
  name        = "lb_security_group"
  description = "Allow SSH and HTTP Connection"
  vpc_id      = var.vpc_id
 
  tags = {
    Name = "stock load balancer secuirty group"
  }

    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to internet
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to internet
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }
}


# RDS Security Group
resource "aws_security_group" "rds" {
  name        = "elb-rds-sg"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.elb_security_group.id]
    description     = "Allow MySQL access from Elastic Beanstalk instances"
  }


}