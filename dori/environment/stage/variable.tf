# VPC CIDR 
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

#Public Subnet 1 CIDR
variable "doripubsub1_cidr" {
  default = "10.0.1.0/24"
}

#Public Subnet 2 CIDR
variable "doripubsub2_cidr" {
  default = "10.0.2.0/24"
}

#Private Subnet 1 CIDR
variable "doriprvsub1_cidr" {
  default = "10.0.3.0/24"
}

#Private Subnet 2 CIDR
variable "doriprvsub2_cidr" {
  default = "10.0.4.0/24"
}

#All IP CIDR
variable "all_ip" {
  default = "0.0.0.0/0"
}

#vpc id
variable "vpc_id" {
  default = ""
}

#ssh port
variable "ssh_port" {
  default = 22
}

#keypair variable
variable "keypair" {
  default = ""
}

#security group
variable "ansible_sg" {
  default = ""
}

#ami
variable "ami" {
  default = "ami-0fdf70ed5c34c5f52"
}

#ami
variable "amiredhart" {
  default = "ami-05c96317a6278cfaa"
}

#instance type
variable "instance_type" {
  default = "t2.medium"

}

#public subnet id
variable "doripubsub1_id" {
  default = ""
}


variable "dori_prv_sn1_id" {
  default = ""
}

#security group
variable "bastion_sg" {
  default = ""
}

#prv_key
variable "prv_key" {
  default = ""
}


#masterip
variable "masterIP" {
  default = ""
}

#workerip
variable "worker1IP" {
  type        = string
  description = "this is the private ip address of worker node 1"
  default     = ""
}

#workerip
variable "worker2IP" {
  default = ""
}


variable "worker1_id" {
  default = ""
}

variable "worker2_id" {
  default = ""
}

variable "master_id" {
  default = ""
}

