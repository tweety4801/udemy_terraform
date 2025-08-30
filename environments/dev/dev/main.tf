module "vpc" {
  source = "../../modules/vpc"
}

module "ec2" {
  source    = "../../modules/ec2"
  allow_ssh = true
  subnet_id = module.vpc.public_subnet_ids[0]
}

module "alb" {
  source     = "../../modules/alb"
  subnet_ids = module.vpc.public_subnet_ids
  instance_id = module.ec2.instance_id
}
