resource "null_resource" "install_everything" {

  connection {
    type        = "ssh"
    user        = var.ssh_user
    private_key = file("${path.module}/my-key.pem")
    host        = var.instance_public_ip
  }

  # Copy install script
  provisioner "file" {
    source      = "${path.module}/install_all_packages.sh"
    destination = "/tmp/install_all_packages.sh"
  }

  # Copy SAP response file
  provisioner "file" {
    source      = "../response.ini"
    destination = "/tmp/response.ini"
  }

  # Execute script
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_all_packages.sh",
      "sudo /tmp/install_all_packages.sh"
    ]
  }
}

# Create AMI after installation
resource "aws_ami_from_instance" "custom_ami" {
  name               = var.ami_name
  source_instance_id = var.instance_id

  depends_on = [
    null_resource.install_everything
  ]

  tags = {
    Name = var.ami_name
    Environment = "Production"
    BuiltBy = "GitHub-Actions"
  }
}
