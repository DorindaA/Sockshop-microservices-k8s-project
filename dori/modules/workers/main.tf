# Create worker1 server
resource "aws_instance" "dori_worker1" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.doriprvsub1_cidr
  vpc_security_group_ids      = [var.dori_workers_sg]
  key_name                    = var.keypair
  

  
  user_data = <<EOF
#!/bin/bash
sudo hostnamectl set-hostname worker1
  EOF

  tags = {
    Name = "dori_worker1"
  }
}

# Create worker2 server
resource "aws_instance" "dori_worker2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.doriprvsub1_cidr
  vpc_security_group_ids      = [var.dori_workers_sg]
  key_name                    = var.keypair


  user_data = <<EOF
#!/bin/bash
sudo hostnamectl set-hostname worker2
  EOF
  tags = {
    Name = "dori_worker2"
  }
}
