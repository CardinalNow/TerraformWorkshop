locals{
  ssh_key_name = "bastion"
}
resource "tls_private_key" "main" {
  algorithm = "RSA"
}

resource "local_file" "private" {
  content  = "${tls_private_key.main.private_key_pem}"
  filename = "./id_rsa_${local.ssh_key_name}.pem"

  provisioner "local-exec" {
    command = "chmod 600 ./id_rsa_${local.ssh_key_name}.pem"
  }
}

resource "local_file" "public" {
  content  = "${tls_private_key.main.public_key_openssh}"
  filename = "./id_rsa_${local.ssh_key_name}.pub"

  provisioner "local-exec" {
    command = "chmod 600 ./id_rsa_${local.ssh_key_name}.pub"
  }
}
