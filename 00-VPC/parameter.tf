resource "aws_ssm_parameter" "vpc-id" {
  name  = "/${var.project}/${var.environment}/vpc-id"
  type  = "String"
  value = module.vpc.vpc_id
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project}/${var.environment}/public-subnet-ids"
  type  = "StringList"
  value = join(",", module.vpc.public_subnet_ids)
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project}/${var.environment}/private-subnet-ids"
  type  = "StringList"
  value = join(",", module.vpc.private_subnet_ids)
}

resource "aws_ssm_parameter" "database_subnet_ids" {
  name  = "/${var.project}/${var.environment}/database-subnet-ids"
  type  = "StringList"
  value = join(",", module.vpc.database_subnet_ids)
}

resource "aws_ssm_parameter" "database_subnet_group_name" {
  name  = "/${var.project}/${var.environment}/database-subnet-group-name"
  type  = "String"
  value = aws_db_subnet_group.expense.name
}