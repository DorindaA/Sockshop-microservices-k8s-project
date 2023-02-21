output "worker1_private_ip" {
  value       = aws_instance.dori_worker1.private_ip
  description = "Worker1 private IP"
}

output "worker2_private_ip" {
  value       = aws_instance.dori_worker2.private_ip
  description = "worker2 private IP"
}


output "worker2_id" {
  value       = aws_instance.dori_worker2.id
  description = "worker2 private IP"
}

output "worker1_id" {
  value       = aws_instance.dori_worker1.id
  description = "Worker1 private IP"
}
