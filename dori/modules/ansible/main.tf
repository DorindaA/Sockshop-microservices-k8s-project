#create ansible server 
resource "aws_instance" "dori_ansible" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.doripubsub1_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.ansible_sg]
  key_name                    = var.keypair

  user_data = local.ansible_user_data
  # Connection Through SSH
  connection {
    type        = "ssh"
    private_key = (var.prv_key)
    user        = "ubuntu"
    host        = self.public_ip
  }
  provisioner "file" {
    source      = "../../modules/ansible/cluster.yml"
    destination = "/home/ubuntu/cluster.yml"
  }

  provisioner "file" {
    source      = "../../modules/ansible/deployment.yml"
    destination = "/home/ubuntu/deployment.yml"
  }
  provisioner "file" {
    source      = "../../modules/ansible/installation.yml"
    destination = "/home/ubuntu/installation.yml"
  }
  provisioner "file" {
    source      = "../../modules/ansible/join.yml"
    destination = "/home/ubuntu/join.yml"
  }

  provisioner "file" {
    source      = "../../modules/ansible/monitoring.yml"
    destination = "/home/ubuntu/monitoring.yml"
  }

  provisioner "file" {
    source      = "../../modules/ansible/deploy-all.yml"
    destination = "/home/ubuntu/deploy-all.yml"
  }



  tags = {
    Name = "dori_ansible"
  }
}