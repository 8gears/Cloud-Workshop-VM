# Workshop VM in the Cloud

This repository makes it a breeze to sping up Workshop VMs on demand in Minutes on AWS or Scaleway together with Terraform.

## Background

When performing hands on workshops it often takes a great amount of time to walk all the participants through the installation process of the needed tools as every participant has a different configuration, machine and operating systems.

A simpler approach is to let the participants spin up a [Vagrant Workshop VM](https://github.com/8gears/workshop-vm) locally and let them do all the course work in that VM. This approach only works when there are no heavily restricted devices or corporate proxies involved that pass HTTP and HTTPS traffic. In such hopeless cases its better to provide a Workshop VM running in the Cloud.

The Primary goal of this repository is to provide an easy and reproducible way to spin up an arbitrary amount VMs on AWS or Scaleway that we use ourself for [Docker & Kubernetes Workshops](https://8gears.com/workshops/). However you can easily customize the setup by adding or removing bash scripts.

## Unique Features

* Few commands to order infrastructure and configuration of the machines with the needed Tools for the Workshop.
* Possibility to overcome restricted corporate environments. Only a Browser is needed to access and work with the VMs. (IE11 will do just fine)
* Workshop VM run Ubuntu 16.04 with Unity Desktop
* Remote Access to the VM via HTML, RDP and SSH. (RDP Client is available on almost every Computer)
* VM with nice UI and Developer friendly Tools for performing the examples.
* Easy to extend and customize by adapting the Bash scripts.

## How It Works

Terrafrom will order the machines on AWS and SCW, after the machines are booted, Terrafrom will also execute scripts in `./files/` on the machines that perform the customization of the machines.

## What Is The Result

When Terrafrom terminates, the machines are directly reachable via its public ip addresses. The Ports 22,80,443 and 3389(RDP) are open. By default there aren't any services on 80/443. Now the workshop participants can connect to the machine via SSH or RDP. Connection via Browser need an installed [HTML Gateway](#overcome-all-proxy-restrictions).

## Requirements

Docker or Terraform need to be installed.

If Terraform isn't installed and Docker is then execute `tf.sh` which is an alias to executes terraform in a container.

## Setup
Customize the parameters in `terraform.tfvars` or `variable.tf` in terms machine count and location.

```sh
terraform init ./aws-tf
terraform plan ./aws-tf
terraform apply ./aws-tf
```

Select `.scw-tf` if you want to provision on Scaleway.
Wait a few minutes. Done!

## Overcome All Proxy Restrictions

Especially at in-house workshops you are often confronted restrictive proxies and firewalls that block all traffic other HTTP and HTTPS. In such allegedly hopeless cases the only solution to access the VMs via a HTML Gateway.

All you need to do is to install [Apache Guacamole](https://guacamole.incubator.apache.org/) on one of the machines. Apache Guacamole is a clientless remote desktop gateway. It supports standard protocols like VNC, RDP, and SSH.

In our [containerized-guacamole](https://github.com/8gears/containerized-guacamole) repository we provide Docker Compose setups that only take a few seconds to spin up an HTML Gateway.

## Responsiveness Results

We have very good experience with machines on AWS, they are very responsive and there is no noticeable lag even in Full HD and 24 Bit Resolution. Scaleway machines(C2M and X64-15GB) had a bit of lag, but it was still possible to work with the machines.
