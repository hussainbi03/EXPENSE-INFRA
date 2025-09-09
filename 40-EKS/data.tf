data "aws_ssm_parameter" "vpc-id" {
  name = "/${var.project_name}/${var.environment}/vpc-id"
}


data "aws_ssm_parameter" "private_subnet_ids" {
  name = "/${var.project_name}/${var.environment}/private-subnet-ids"
}

data "aws_ssm_parameter" "eks-control-plane-sg-id" {
  name = "/${var.project_name}/${var.environment}/eks-control-plane-sg-id"
}

data "aws_ssm_parameter" "eks-node-sg-id" {
  name = "/${var.project_name}/${var.environment}/eks-node-sg-id"
}