module "mainvpc" {
  source                 = "./module/network"
  public_subnet_cidrs    = var.public_subnet_cidrs
  private_subnet_cidrs   = var.private_subnet_cidrs
  vpc_cidr               = var.vpc_cidr
  vpc_security_group_ids = module.security_group.elb_security_group_id
  vpc_id                 = module.mainvpc.vpc_id
  public_subnet_id       = module.mainvpc.public_subnet_id[*]
  private_subnet_id      = module.mainvpc.private_subnet_id[*]

  tags = {
    Name = "Create VPC"
  }
}

module "security_group" {
  source = "./module/securitygroup"
  vpc_id = module.mainvpc.vpc_id
}

module "load_balancer" {
  source               = "./module/alb"
  alb_name             = "elb-algo-alb"
  vpc_id               = module.mainvpc.vpc_id
  public_subnet_id     = module.mainvpc.public_subnet_id
  lb_security_group_id = [module.security_group.alb_security_group_id]
  target_group_name    = "elb-alb-tg"
}

module "rds" {
  source                 = "./module/rds"
  db_identifier          = "elb-db"
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = var.db_password
  db_instance_class      = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  engine                 = "postgres"
  engine_version         = "17.2"
  vpc_security_group_ids = [module.security_group.rds_security_group_id]
  subnet_ids             = module.mainvpc.private_subnet_id
  multi_az               = true
}

module "s3" {
  source = "./module/s3"

  bucket_name            = "${var.project_name}-uploads-${var.environment}"
  deployment_bucket_name = "${var.project_name}-deployment-${var.environment}"
  //tags                   = local.tags
}

module "iam" {
  source = "./module/iam"


  //tags                     = local.tags
  app_name                 = var.project_name
  s3_access_policy_arn     = module.s3.access_policy_arn
  s3_deployment_policy_arn = module.s3.deployment_access_policy_arn

}

module "elastic_beanstalk" {
  source = "./module/elasticbeanstalk"

  app_name                   = var.project_name
  app_description            = "Flask App with RDS and S3"
  environment_name           = "${var.project_name}-${var.environment}"
  aws_region                 = var.aws_region
  vpc_id                     = module.mainvpc.vpc_id
  subnet_ids                 = module.mainvpc.private_subnet_id[*]
  instance_type              = var.eb_instance_type
  min_instances              = var.eb_min_instances
  max_instances              = var.eb_max_instances
  lb_security_group_id       = module.security_group.alb_security_group_id
  instance_profile_name      = module.iam.eb_ec2_instance_profile_name
  instance_security_group_id = module.security_group.elb_security_group_id
  public_subnet_ids          = module.mainvpc.public_subnet_id[*]
  private_subnet_ids         = module.mainvpc.private_subnet_id[*]
  //tags                       = local.tags
  service_role_arn    = module.iam.eb_service_role_arn
  uploads_bucket_name = module.s3.bucket_name

}