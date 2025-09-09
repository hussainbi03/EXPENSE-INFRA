module "sg-mysql" {
    #source = "../../../terraform-aws-sg-module"
    source = "git::https://github.com/hussainbi03/terraform-aws-sg-module.git?ref=main"
    project = var.project
    environment = var.environment
    sg_name= "mysql"
    description = var.description
    common_tags = var.common_tags
    vpc_id =  data.aws_ssm_parameter.vpc_id.value
}


module "sg-bastion" {
    source = "../../../terraform-aws-sg-module"
    project = var.project
    environment = var.environment
    sg_name= "bastion"
    description = var.description
    common_tags = var.common_tags
    vpc_id =  data.aws_ssm_parameter.vpc_id.value
}

module "sg-alb-ingress" {
    source = "../../../terraform-aws-sg-module"
    project = var.project
    environment = var.environment
    sg_name= "alb"
    description = var.description
    common_tags = var.common_tags
    vpc_id =  data.aws_ssm_parameter.vpc_id.value
}
module "sg-eks-control-plane" {
    source = "../../../terraform-aws-sg-module"
    project = var.project
    environment = var.environment
    sg_name= "sg-eks-control-plane"
    description = var.description
    common_tags = var.common_tags
    vpc_id =  data.aws_ssm_parameter.vpc_id.value
}

module "sg-eks-node" {
    source = "../../../terraform-aws-sg-module"
    project = var.project
    environment = var.environment
    sg_name= "sg-eks-node"
    description = var.description
    common_tags = var.common_tags
    vpc_id =  data.aws_ssm_parameter.vpc_id.value
}

#rule to allow trafic from node to cluster
resource "aws_security_group_rule" "eks-control-plane-eks-node" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id       = module.sg-eks-node.sg_id
  security_group_id = module.sg-eks-control-plane.sg_id
}

#rule to allow trafic from bastion to cluster
resource "aws_security_group_rule" "eks-control-plane-eks-bastion" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id       = module.sg-bastion.sg_id
  security_group_id = module.sg-eks-control-plane.sg_id
}

#rule to allow trafic from cluster to node
resource "aws_security_group_rule" "node-eks-control-plane-eks" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id       = module.sg-eks-control-plane.sg_id
  security_group_id = module.sg-eks-node.sg_id
}

#rule to allow trafic from alb to node
resource "aws_security_group_rule" "node-alb-ingress" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 32767
  protocol          = "TCP"
  source_security_group_id       = module.sg-alb-ingress.sg_id
  security_group_id = module.sg-eks-node.sg_id
}

#rule to allow trafic from public to alb
resource "aws_security_group_rule" "alb-ingress-public-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.sg-alb-ingress.sg_id
}

#rule to allow trafic from vpc to node
resource "aws_security_group_rule" "node-vpc" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = module.sg-eks-node.sg_id
}

#rule to allow trafic from bastion to node
resource "aws_security_group_rule" "node-bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "TCP"
    source_security_group_id       = module.sg-bastion.sg_id
  security_group_id = module.sg-eks-node.sg_id
}

#rule to allow trafic from basition to alb
resource "aws_security_group_rule" "bastion-sg-alb-ingress-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  source_security_group_id       = module.sg-bastion.sg_id
  security_group_id = module.sg-alb-ingress.sg_id
}
#rule to allow trafic from basition to alb
resource "aws_security_group_rule" "bastion-sg-alb-ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id       = module.sg-bastion.sg_id
  security_group_id = module.sg-alb-ingress.sg_id
}

#rule to allow trafic from public to basition
resource "aws_security_group_rule" "bastion-public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
 cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.sg-bastion.sg_id
}

#rule to allow trafic from bastion to mysql
resource "aws_security_group_rule" "mysql-bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.sg-bastion.sg_id
  security_group_id = module.sg-mysql.sg_id
}

#rule to allow trafic from eks-node to mysql
resource "aws_security_group_rule" "mysql-eks-node" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id = module.sg-eks-node.sg_id
  security_group_id = module.sg-mysql.sg_id
}

 
 