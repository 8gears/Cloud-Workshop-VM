variable "region" {
  default = "par1"
}
variable "scw_access_key" {
  description = "Scaleway Access Key"
}

variable "scw_generated_token" {
  description = "Scaleway Access Token"
}

variable "instance_type" {
  default = "C2M"
}

variable "instance_count" {
  default = 2
}

variable "key_pair_public_key" {
   description = "The public key add"
   #default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC25FZPGGM3amzycxCscqP+KUMXPzVodRu+lXbvzsuhhfH8uxzMksaNC5VGRGOt7jljvbaPRNy9d+hRhZhP4Bc4fK0D+ancdGV3W2TBqDApG7UMlYKqo7ALvVcSbYuFTaS7mXuMvuQieXWTpnDLYjTAduzajd5YtieHiLDtEr0/uJsrtxZWVmIhFxjW1fdpoKudnD9AzF2UBEhU4dFBzTSd9vs7kcus9GJksjCo1NRTMeTcIYblRJ9lD2ZaXZufS8ez+xfSyLXn/BLv03EEnimly6n76h8RFQosZJYZ7Iv47jTJzozYxDNNWGaBEWURaFaYMBMy3S/c9f3HCwjon9lKkbM/vbR+YHb+bHRvK17rqWyL69pJUGJXvTbedLmoRZwp/IPx30nmEKuYUDoThimdZ5Q8eHzWa8VJaVBmCmtfJrKBGV8VnoNKm4gTlH4hDbZZLS1eUYsxgp4QBYNljjmZNRKIplzkONjsA8wrFiU6IgRVhwYnCbzQeFiIkzp48zDEUn3Bg+SYTkyCpKbFL5Y+XxWo+JBH6zD5z/5/OmXjN3FYDQFDVnIxGU9ckefMEaH04O6gZ9XszXtzfeAenE2jvYsFKXz8llqdU4fRTan5H6q/H+6qbgYU5Nwm1388TujljO/yZC4xS48zfCnzuilg+21ZIwlIZ7ZpYfZMD0ZsUQ== vadim@vs-macfly.local"
}
