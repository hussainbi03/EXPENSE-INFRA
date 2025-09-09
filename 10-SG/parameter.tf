resource "aws_ssm_parameter" "mysql-sg-id" {
  name  = "/${var.project}/${var.environment}/mysql-sg-id"
  type  = "String"
  value = module.sg-mysql.sg_id
}


resource "aws_ssm_parameter" "bastion-sg-id" {
  name  = "/${var.project}/${var.environment}/bastion-sg-id"
  type  = "String"
  value = module.sg-bastion.sg_id
}

resource "aws_ssm_parameter" "alb-ingress-sg-id" {
  name  = "/${var.project}/${var.environment}/alb-ingress-sg-id"
  type  = "String"
  value = module.sg-alb-ingress.sg_id
}

resource "aws_ssm_parameter" "eks-control-plane-sg-id" {
  name  = "/${var.project}/${var.environment}/eks-control-plane-sg-id"
  type  = "String"
  value = module.sg-eks-control-plane.sg_id
}

resource "aws_ssm_parameter" "eks-node-sg-id" {
  name  = "/${var.project}/${var.environment}/eks-node-sg-id"
  type  = "String"
  value = module.sg-eks-node.sg_id
}

