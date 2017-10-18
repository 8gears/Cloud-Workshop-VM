
output "public_ip" {
  value = "${concat(scaleway_server.machine.*.name, scaleway_server.machine.*.public_ip)}"
}

output "workspace" {
  value = "${terraform.workspace}"
}
