#configuracion de las variables que se utilizan en el main.tf
#el la variable do_token tiene que colocar el token q genera digital ocean
#y la variable droplet_ssh key es el id que se genera cuando genera la llave ssh
do_token = ""
ssh_key_private = "~/.ssh/id_rsa"
droplet_ssh_key_id = ""
droplet_size = "s-1vcpu-1gb"
droplet_region = "nyc3"