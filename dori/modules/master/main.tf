#create master server
resource "aws_instance" "dori_Master" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.doriprvsub1_cidr
  vpc_security_group_ids      = [var.dori_Master_sg]
  key_name                    = var.keypair
  

  user_data = <<EOF
#!/bin/bash
sudo hostnamectl set-hostname master
  EOF


  tags = {
    Name = "dori_master"
  }
}