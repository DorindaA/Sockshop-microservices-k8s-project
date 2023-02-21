output "dori_pub_key" {
  value = aws_key_pair.dori_pub_key.key_name
}

output "prv_key" {
  value = tls_private_key.dori_key.private_key_pem
}
