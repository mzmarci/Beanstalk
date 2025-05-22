output "elb_security_group_id" {
  value =  aws_security_group.elb_security_group.id
}

output "alb_security_group_id" {
  value = aws_security_group.lb_security_group.id
}

output "rds_security_group_id" {
  value= aws_security_group.rds.id
}

