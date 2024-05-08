provider "aws" {
  region = var.region
}

module "vpc" {
  source       = "../modules/vpc"
  region       = var.region
  project_name = var.project_name
  cidr         = var.cidr
  pri_sub_2a   = var.pri_sub_2a
  pri_sub_2b   = var.pri_sub_2b
  pub_sub_2a   = var.pub_sub_2a
  pub_sub_2b   = var.pub_sub_2b

}

#creating security group
module "sg" {
  source = "../modules/securitygroup"
  vpc_id = module.vpc.vpc_id
  my_ip  = var.my_ip
}

# Creating NAT Gateway
module "nat_gateway" {
  source                     = "../modules/nat-gateway"
  public_subnet_2a_id       = module.vpc.public_subnet_2a_id
  internet_gateway           = module.vpc.internet_gateway
  public_subnet_2b_id       = module.vpc.public_subnet_2b_id
  vpc_id                     = module.vpc.vpc_id
  private_subnet_2a_id = module.vpc.private_subnet_2a_id
  private_subnet_2b_id = module.vpc.private_subnet_2b_id
}

module "auto-sg" {
  source                   = "../modules/auto-sg"
  project_name = module.vpc.project_name
  private_subnet_2a_id = module.vpc.private_subnet_2a_id
  private_subnet_2b_id = module.vpc.private_subnet_2b_id
  public_subnet_2a_id = module.vpc.public_subnet_2a_id
  public_subnet_2b_id = module.vpc.public_subnet_2b_id
  private_instance_security_group_id = module.sg.private_instance_security_group_id
  public_instance_security_group_id = module.sg.public_instance_security_group_id

}