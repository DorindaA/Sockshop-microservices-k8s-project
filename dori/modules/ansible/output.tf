output "ansible_IP" {
  value       = aws_instance.dori_ansible.public_ip
  description = "Ansible public IP"
}