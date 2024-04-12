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
