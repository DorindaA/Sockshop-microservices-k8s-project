module "vpc" {
  source   = "../../modules/VPC"
  vpc_cidr = var.vpc_cidr

}

module "Subnet" {
  source           = "../../modules/subnets"
  doripubsub1_cidr = var.doripubsub1_cidr
  doripubsub2_cidr = var.doripubsub2_cidr
  doriprvsub1_cidr = var.doriprvsub1_cidr
  doriprvsub2_cidr = var.doriprvsub2_cidr
  all_ip           = var.all_ip
  vpc_id           = module.vpc.vpc_id
}

module "Security_groups" {
  source   = "../../modules/Security-groups"
  ssh_port = var.ssh_port
  vpc_id   = module.vpc.vpc_id
  all_ip   = var.all_ip
}

module "keypair" {
  source = "../../modules/keypair"
}

module "ansible" {
  source         = "../../modules/ansible"
  keypair        = module.keypair.dori_pub_key
  ami            = var.ami
  instance_type  = var.instance_type
  ansible_sg     = module.Security_groups.ansible_sg
  doripubsub1_id = module.Subnet.pubsub_1
  prv_key        = module.keypair.prv_key
  masterIP       = module.master.Master_private_ip
  worker1IP      = module.workers.worker1_private_ip
  worker2IP      = module.workers.worker2_private_ip


}

module "bastion" {
  source         = "../../modules/bastion"
  keypair        = module.keypair.dori_pub_key
  prv_key        = module.keypair.prv_key
  ami            = var.ami
  instance_type  = var.instance_type
  bastion_sg     = module.Security_groups.bastion_sg
  doripubsub1_id = module.Subnet.pubsub_1
}

module "workers" {
  source           = "../../modules/workers"
  keypair          = module.keypair.dori_pub_key
  ami              = var.ami
  instance_type    = var.instance_type
  dori_workers_sg  = module.Security_groups.workers_sg
  doriprvsub1_cidr = module.Subnet.prvsub_1
}

module "master" {
  source           = "../../modules/master"
  keypair          = module.keypair.dori_pub_key
  ami              = var.ami
  instance_type    = var.instance_type
  dori_Master_sg   = module.Security_groups.master_sg
  doriprvsub1_cidr = module.Subnet.prvsub_1

}



module "load" {
  source         = "../../modules/load-balancer"
  worker1_id     = module.workers.worker1_id
  worker2_id     = module.workers.worker2_id
  master_id      = module.master.master_id
  vpc_id         = module.vpc.vpc_id
  doripubsub1_id = [module.Subnet.pubsub_1, module.Subnet.pubsub_2]
  doripubsub2_id = [module.Subnet.pubsub_1, module.Subnet.pubsub_2]
}
