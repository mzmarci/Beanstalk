# Application Load Balancer (ALB) for frontend & middle
resource "aws_lb" "elb_alb" {
  name               = var.alb_name
  internal           = false  
  load_balancer_type = "application"
  security_groups    = var.lb_security_group_id
  subnets            = var.public_subnet_id
  enable_deletion_protection = false

  tags = {
    Name = var.alb_name
  }
}

# ALB Listeners
resource "aws_lb_listener" "elb_listener" {
  load_balancer_arn = aws_lb.elb_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.elb_tg.arn
  }
}


# Target Group
resource "aws_lb_target_group" "elb_tg" {
  name        = "${var.alb_name}-elb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    path                = var.health_check_path
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }
}

