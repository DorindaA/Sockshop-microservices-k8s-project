locals {
  ansible_user_data = <<-EOF
#!/bin/bash
sudo apt-get update -y
sudo apt-get install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y
echo "${var.prv_key}" >> /home/ubuntu/.ssh/sock-key
sudo bash -c 'echo "StrictHostKeyChecking No" >> /etc/ssh/ssh_config'
sudo chmod 400 dori_prv
sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/sock-key 
sudo chgrp ubuntu:ubuntu /home/ubuntu/.ssh/sock-key 
sudo chmod 400 /home/ubuntu/.ssh/sock-key
sudo echo "[Master]" > /etc/ansible/hosts
sudo echo "${var.masterIP} ansible_ssh_private_key_file=/home/ubuntu/.ssh/sock-key" >> /etc/ansible/hosts
sudo echo "[worker1]" >> /etc/ansible/hosts
sudo echo "${var.worker1IP} ansible_ssh_private_key_file=/home/ubuntu/.ssh/sock-key" >> /etc/ansible/hosts
sudo echo "[worker2]" >> /etc/ansible/hosts
sudo echo "${var.worker2IP} ansible_ssh_private_key_file=/home/ubuntu/.ssh/sock-key" >> /etc/ansible/hosts
sudo chown -R ubuntu:ubuntu /etc/ansible
sudo hostnamectl set-hostname Ansible
sudo su -c 'ansible-playbook -i /etc/ansible/hosts /home/ubuntu/deploy-all.yml' ubuntu

EOF
}

