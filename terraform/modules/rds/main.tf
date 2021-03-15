#generate password
resource "random_string" "db_footgo_pass" {
  length           = 8
  special          = true
  override_special = "!#$&"
}

# Store Password in SSM Parameter Store
resource "aws_ssm_parameter" "db_footgo_pass" {
  name        = "/dev/mysql"
  description = "Footgo Password for RDS MySQL"
  type        = "SecureString"
  value       = random_string.db_footgo_pass.result
}

data "aws_ssm_parameter" "db_footgo_pass" {
  name       = "/dev/mysql"
  depends_on = [aws_ssm_parameter.db_footgo_pass]
}

resource "aws_ecr_repository" "epam_project" {
  name                 = "olehzz_footgo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_db_instance" "mysql_db" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  db_subnet_group_name   = var.db_subnet_group_name
  name                   = "footgo"
  vpc_security_group_ids = [var.mysql_sg]
  username               = "footgo"
  password               = data.aws_ssm_parameter.db_footgo_pass.value
  skip_final_snapshot  = true
  apply_immediately = true
}