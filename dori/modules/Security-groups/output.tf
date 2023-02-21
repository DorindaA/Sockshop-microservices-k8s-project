output "ansible_sg" {
  value = aws_security_group.dori_ansible_sg.id
}

output "master_sg" {
  value = aws_security_group.dori_Master_sg.id
}

output "workers_sg" {
  value = aws_security_group.dori_workers_sg.id
}

output "bastion_sg" {
  value = aws_security_group.dori_bastion_sg.id
}
