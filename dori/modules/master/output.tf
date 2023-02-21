#MASTER OUTPUT
output "Master_private_ip" {
  value       = aws_instance.dori_Master.private_ip
  description = "Master private IP"
}

output "master_id" {
  value = aws_instance.dori_Master.id
}