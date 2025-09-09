locals{
    name = "${var.project_name}-${var.environment}"
    vpc_id = data.aws_ssm_parameter.vpc-id.value
    private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
    eks_control_plane_sg_id = data.aws_ssm_parameter.eks-control-plane-sg-id.value
    eks_node_sg_id = data.aws_ssm_parameter.eks-node-sg-id.value
}