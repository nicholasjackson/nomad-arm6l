provider "scaleway" {}

data "template_file" "bootscript" {
  template = "${file("./install.sh")}"

  vars {
    go_version    = "go${var.go_version}.linux-armv6l"
    nomad_version = "${var.nomad_version}"
  }
}

resource "random_id" "server_name" {
  byte_length = 8
}

resource "scaleway_server" "build" {
  name                = "arm7-build-${random_id.server_name.dec}"
  image               = "3a1b0dd8-92e1-4ba2-aece-eea8e9d07e32"
  type                = "C1"
  dynamic_ip_required = true

  volume {
    size_in_gb = 20
    type       = "l_ssd"
  }

  # add the build script
  provisioner "file" {
    connection {
      host        = "${scaleway_server.build.public_ip}"
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.ssh_key}")}"
    }

    content     = "${data.template_file.bootscript.rendered}"
    destination = "/tmp/script.sh"
  }

  # add the install bootstrap script
  provisioner "file" {
    connection {
      host        = "${scaleway_server.build.public_ip}"
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.ssh_key}")}"
    }

    content     = "${file("build.sh")}"
    destination = "/root/build.sh"
  }

  # bootstrap the server
  provisioner "remote-exec" {
    connection {
      host        = "${scaleway_server.build.public_ip}"
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.ssh_key}")}"
    }

    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
      "sudo systemctl restart sshd",
    ]
  }
}

output "public_ip" {
  value = "${scaleway_server.build.public_ip}"
}
