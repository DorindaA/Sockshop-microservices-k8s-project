output "master-dns" {
 value = aws_lb.master-lb.dns_name
}

output "worker1-dns" {
 value = aws_lb.worker1-lb.dns_name
}

output "worker2-dns" {
 value = aws_lb.worker2-lb.dns_name
}