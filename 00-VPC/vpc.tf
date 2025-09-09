module "vpc" {
  source            = "../../../aws-terraform-vpc"
  project           = var.project
  environment       = var.environment
  vpc_cidr          = var.cidr_block
  common_tags       = var.common_tags
  public_cidr_block = var.public_cidr_block
  private_cidr_block = var.private_cidr_block
  database_cidr_block = var.database_cidr_block
  is_peering_required = true

}

# this can be included in module
resource "aws_db_subnet_group" "expense" {
  name       = "${var.project}-${var.environment}"
  subnet_ids = module.vpc.database_subnet_ids

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project}-${var.environment}"
    }
  )
}