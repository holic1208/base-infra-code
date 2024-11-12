module "vpc" {
  source = "../../module/network/vpc"

  name                 = "base-infra"
  vpc_cidr_block       = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  azs                  = var.azs
  pub_subnet           = var.sub_cidr_block.public
}
