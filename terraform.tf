provider "scaleway" {}

data "template_file" "bootscript" {
  filename = "./install.sh"

  vars {
    GOVERSION     = "go1.9.3.linux-armv6l"
    NOMAD_VERSION = "v0.7.1"
  }
}

resource "scaleway_server" "build" {
  name                = "arm7-build"
  image               = "3a1b0dd8-92e1-4ba2-aece-eea8e9d07e32"
  type                = "C1"
  dynamic_ip_required = true

  volume {
    size_in_gb = 20
    type       = "l_ssd"
  }

  provisioner "remote-exec" {
    connection {
      host        = "${scaleway_server.build.public_ip}"
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.ssh_key}")}"
    }

    inline = "${data.template_file.bootscript.rendered}"
  }
}

output "public_ip" {
  value = "${scaleway_server.build.public_ip}"
}
