output "ansible_IP" {
  value       = module.ansible.ansible_IP
  description = "Ansible public IP"
}

output "bastion_public_ip" {
  value       = module.bastion.bastion_public_ip
  description = "Bastion public IP"
}
output "worker1_private_ip" {
  value       = module.workers.worker1_private_ip
  description = "worker1 public IP"
}

output "worker2_private_ip" {
  value       = module.workers.worker2_private_ip
  description = "worker1 public IP"
}

output "master_private_ip" {
  value       = module.master.Master_private_ip
  description = "master public IP"
}

output "master-dns" {
  value       = module.load.master-dns
  description = "master dns"
}

output "worker1-dns" {
  value       = module.load.worker1-dns
  description = "worker1 dns"
}

output "worker2-dns" {
  value       = module.load.worker2-dns
  description = "worker2 dns"
}