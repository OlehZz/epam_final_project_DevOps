data "aws_availability_zones" "az" {
}

terraform {
  backend "s3" {
    bucket = "epam-task"
    key    = "epam_project/terraform.tfstate"
    region = "us-east-1"
  }

}

module "vpc-main" {
  source = "./modules/aws_network"
}

module "security-group" {
  source = "./modules/security_group"
  vpc_id = module.vpc-main.vpc_id
}

module "asg_elb" {
  source           = "./modules/asg_elb"
  public_subnet_id = module.vpc-main.dev_public_subnet_id
  #private_subnet_ids = module.vpc-main.dev_private_subnet_ids
  webserver_sg             = module.security-group.webserver_sg
  aws_launch_configuration = module.instances.aws_launch_configuration_name

}

module "instances" {
  source       = "./modules/instances"
  webserver_sg = module.security-group.webserver_sg
  AMI_ID = var.AMI_ID
  PRIVATE_KEY = var.PRIVATE_KEY
  public_subnet_id = module.vpc-main.dev_public_subnet_id
}

module "rds" {
  source               = "./modules/rds"
  db_subnet_group_name = module.vpc-main.db_subnet_group_name
  mysql_sg             = module.security-group.mysql_sg
}