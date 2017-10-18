resource "aws_instance" "ec2_ondemand_instance" {
   count                   = "${var.vm_nodes_count}"
   ami                     = "ami-1e339e71"
   instance_type           = "${var.aws_instance_type}"
   key_name                = "${aws_key_pair.deployer.key_name}"
   monitoring              = true
   vpc_security_group_ids  = ["${module.wvm_ssh_sg.this_security_group_id}"]
   subnet_id               = "${module.vpc.public_subnets[0]}"
   associate_public_ip_address = true

    root_block_device {
      volume_size = 50
      volume_type = "io1"
      iops        = "2500"
    }

   tags = {
      Name        = "workshop-vm-${count.index+1}"
      Terraform   = "true"
      Environment = "${var.tag_environment}"
   }


   connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.private_key_file}")}"
   }

   provisioner "file" {
      source      = "files/"
      destination = "/tmp/"
   }

   provisioner "remote-exec" {
      inline = [
         "sudo sh /tmp/install-desktop.sh",
         "sudo sh /tmp/install-xrdp-1.9.1.sh",         
         "sudo sh /tmp/docker.sh",                      
         "sudo sh /tmp/git-bash-prompt.sh",         
         "sudo sh /tmp/mod-bash.sh",     
         "sudo sh /tmp/openshift.sh",
         "sudo sh /tmp/install-packages.sh",
         "sudo bash /tmp/user-settings.sh ${var.workshop_user_password}",
         "sudo sh /tmp/locale.sh",
      ]
   }
}

module "wvm_ssh_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "wvm default"
  description = "Default Security group for the workshop VMs. with SSH,HTTP/S and RDP"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["ssh-tcp","http-80-tcp","https-443-tcp"]  
  ingress_with_cidr_blocks = [{
     from_port   = 3389
     to_port     = 3389
     protocol    = "tcp"
     description = "RDP"
     cidr_blocks = "0.0.0.0/0"
     },{
     from_port   = 3389
     to_port     = 3389
     protocol    = "udp"
     description = "RDP over UDP"
     cidr_blocks = "0.0.0.0/0"
     },
   ]
  ingress_ipv6_cidr_blocks = ["::/0"]

  #egress_cidr_blocks = []
  #egress_ipv6_cidr_blocks = []
  #egress_rules = ["all-all"]
  egress_with_cidr_blocks = [
    {
      rule             = "all-all"
      cidr_blocks      = "0.0.0.0/0"
      ipv6_cidr_blocks = "::/0"
    },]
}

resource "aws_key_pair" "deployer" {
  key_name = "deployer_authorized_keys"
  public_key = "${var.key_pair_public_key}"
}
