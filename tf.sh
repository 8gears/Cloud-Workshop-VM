docker run -ti --rm --workdir='/work' -v $PWD:/work -v $HOME:$HOME -u $(id -u):$(id -g) hashicorp/terraform "$@"
