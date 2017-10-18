output "private_ip" {
  value = ["${aws_instance.ec2_ondemand_instance.*.private_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.ec2_ondemand_instance.*.public_dns}"]
}

output "public_ip" {
  value = ["${aws_instance.ec2_ondemand_instance.*.public_ip}"]
}

