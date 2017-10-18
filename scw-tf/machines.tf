resource "scaleway_ip" "machine_ip" {
   count = "${var.instance_count}"
}

resource "scaleway_server" "machine" {
   count          = "${var.instance_count}"
   name           = "${terraform.workspace}-worker-${count.index + 1}"
   image          = "${data.scaleway_image.xenial.id}"
   type           = "${var.instance_type}"
   bootscript     = "${data.scaleway_bootscript.mainline.id}"
   security_group = "e75cec3d-223a-406a-b3d1-72c064626a37"
   public_ip      = "${element(scaleway_ip.machine_ip.*.ip, count.index)}"
   tags           = ["WORKSHOP"]

   connection {
      type = "ssh"
      user = "root"
      private_key = "${file("~/.ssh/id_rsa")}"
   }

   # provisioner "remote-exec" {
   #    inline = [
   #       "mkdir -p /etc/systemd/system/docker.service.d",
   #    ]
   # }

   # provisioner "file" {
   #    content     = "${data.template_file.docker_conf.rendered}"
   #    destination = "/etc/systemd/system/docker.service.d/docker.conf"
   # }

   #   provisioner "file" {
   #     source      = "scripts/install-docker-ce.sh"
   #     destination = "/tmp/install-docker-ce.sh"
   #   }

   provisioner "remote-exec" {
      scripts = [
         "files/install-desktop.sh",
         "files/install-xrdp-1.9.1.sh",         
         "files/docker.sh",                      
         "files/git-bash-prompt.sh",         
         "files/mod-bash.sh",     
         "files/openshift.sh",
         "files/install-packages.sh",
         "files/user-settings.sh",
         "files/locale.sh",
      ]
   }

   provisioner "remote-exec" {
      script = ""
   }
   
   # provisioner "remote-exec" {
   #    inline = [
   #       "chmod +x /tmp/install-docker-ce.sh",
   #       "/tmp/install-docker-ce.sh ${var.docker_version}",
   #       "docker swarm join --token ${data.external.swarm_tokens.result.worker} ${scaleway_server.swarm_manager.0.private_ip}:2377",
   #    ]
   # }

   # drain worker on destroy
   # provisioner "remote-exec" {
   #    when = "destroy"

   #    inline = [
   #       "docker node update --availability drain ${self.name}",
   #    ]

   #    on_failure = "continue"

   #    connection {
   #       type = "ssh"
   #       user = "root"
   #       host = "${scaleway_ip.swarm_manager_ip.0.ip}"
   #    }
   # }

   # leave swarm on destroy
   # provisioner "remote-exec" {
   #    when = "destroy"

   #    inline = [
   #       "docker swarm leave",
   #    ]

   #    on_failure = "continue"
   # }

   # remove node on destroy
   # provisioner "remote-exec" {
   #    when = "destroy"

   #    inline = [
   #       "docker node rm --force ${self.name}",
   #    ]

   #    on_failure = "continue"

   #    connection {
   #       type = "ssh"
   #       user = "root"
   #       host = "${scaleway_ip.swarm_manager_ip.0.ip}"
   #    }
   # }
}

# data "external" "swarm_tokens" {
#    program = ["./scripts/fetch-tokens.sh"]

#    query = {
#       host = "${scaleway_ip.swarm_manager_ip.0.ip}"
#    }

#    depends_on = ["scaleway_server.swarm_manager"]
# }
