# Create Ansible Security Group
resource "aws_security_group" "dori_ansible_sg" {
  name        = "dori-ansible-sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [""] ##my local pc ipaddress
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dori_ansible_sg"
  }
}

# Create Master Security Group
resource "aws_security_group" "dori_Master_sg" {
  name        = "dori_Master_sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id


  ingress {
    description = "Kubernetes API server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }
    ingress {
    description = "etcd server client API"
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

    ingress {
    description = "Kubelet API"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

    ingress {
    description = "kube-scheduler"
    from_port   = 10259
    to_port     = 10259
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

    ingress {
    description = "kube-controller-manager"
    from_port   = 10257
    to_port     = 10257
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

    ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"] ## my local pc ip address
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = "true"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  ingress {
    from_port   = 9411
    to_port     = 9411
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }
  ingress {
    from_port   = 30001
    to_port     = 30001
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  ingress {
   from_port   = 31601
   to_port     = 31601
   protocol    = "tcp"
   cidr_blocks = ["10.0.1.0/24"]
 }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dori_Master_sg"
  }
}

# Create workers Security Group
resource "aws_security_group" "dori_workers_sg" {
  name        = "dori_workers_sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Kubelet API"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }
    ingress {
    description = "NodePort Services"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }
    ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dori_workers_sg"
  }
}

# Security group for Bastion Host
resource "aws_security_group" "dori_bastion_sg" {
  name        = "dori_bastion_sg"
  description = "Allow traffic for ssh"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow ssh traffic"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = []## my local pc ip address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ip]
  }

  tags = {
    Name = "dori_bastion_sg"
  }
}
