resource "aws_key_pair" "ssh_key_pair" {
  key_name   = var.ec2_key_name
  public_key = tls_private_key.rsa_key_pair.public_key_openssh
}

resource "tls_private_key" "rsa_key_pair" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "local_file" "private_key" {
  filename        = "private-key-${var.environment}.pem"
  file_permission = "0400"
  content         = tls_private_key.rsa_key_pair.private_key_pem
}