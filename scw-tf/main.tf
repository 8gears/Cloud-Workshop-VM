provider "scaleway" {
  organization = "${var.scw_access_key}"
  token        = "${var.scw_generated_token}"
  region       = "par1"
}

data "scaleway_bootscript" "mainline" {
  architecture = "x86_64"
  name = "x86_64 4.10.8 docker #1"
}

data "scaleway_image" "xenial" {
  architecture = "x86_64"
  name         = "Ubuntu Xenial"
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
