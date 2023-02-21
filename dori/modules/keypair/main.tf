# create KeyPair 
resource "tls_private_key" "dori_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "dori_prv" {
  content  = tls_private_key.dori_key.private_key_pem
  filename = "dori_prv"
}


resource "aws_key_pair" "dori_pub_key" {
  key_name   = "dori_pub_key"
  public_key = tls_private_key.dori_key.public_key_openssh
}