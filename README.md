INSTRUCCIONES EJERCICIO 1
A continuacion se detallan las instrucciones para ejecutar el ejercicio.
tener en cuenta que se debe de tener previamente instalado
--visual studio code
--ansible
--doctl para digital ocean
--cuenta en digital ocean
--terraform
ya habiendo descargado el repositorio o el codigo
corremos el siguiente comando, este comando es para iniciar terraform
--> terraform init

luego ejecutamos el comando, este es para verificacion de todo el codigo y verificar si existe 
en algun error en el mismo, si no da error (que no da jeje) 
-->terraform plan 
luego de verificado el codigo y que no da error ejecutamos el comando 
con este comando se levantan los servicios que se configuraron.
-->terraform apply
 aqui nos va a empezar a levantar todos los servicios en Digital Ocean y asi podriamos ver
 los droplets que se crearon.

 ya habiendo levantado los servicios y probados, procedemos a destruir lo que se creo en Digital Ocean
 y asi no siga cobramdo. se ejecuta el siguiente comando
 --> terraform destroy
 y con esto se elimina todo.





INSTRUCCIONES EJERCICIO 2

A continuacion se detallan las instrucciones y comandos correr el ejercicio 2.

debemos de tener previamente instalado 
--visual studio code
--VMWare 
--vagrant
ya teniendo el codigo o descargado el repositorio de git. 

corremos el comando 
---> vagrant up
esto nos sirve para levantar las VMs, las cuales seran provionadas con VMWare desktop
puede domorar un poco de tiempo dependiendo del ancho de banda que se tenga.

Cuando haya finalizado, podemos verificar si se instalaron las VMs con el siguiente comando.
---> vagrant status
aqui nos debe de salir el estado de las maquinas virtuales.
Ejemplo
#manager                   running (vmware_desktop)
#worker1                   running (vmware_desktop)
Hasta este punto ya se tienen las VMs.

Ahora procedemos a levantar el Cluster de Docker Swarm, para ello debemos ingresr via ssh
a la VM maganer con el siguiente comando.
--> vagrant ssh manager
Ya estando dentro de la VM via ssh, podemos correr el comando 
--> docker version
Esto para verificar que docker si esta instalado, deberia de aparecer algo similar a esto.
vagrant@manager ~ $ docker version
#---------------------
vagrant@manager ~ $ docker version
Client:
 Version:      1.12.1
 API version:  1.24
 Go version:   go1.6.3
 Git commit:   23cf638
 Built:        Thu Aug 18 05:22:43 2016
 OS/Arch:      linux/amd64

Server:
 Version:      1.12.1
 API version:  1.24
 Go version:   go1.6.3
 Git commit:   23cf638
 Built:        Thu Aug 18 05:22:43 2016
 OS/Arch:      linux/amd64
#---------------------
Para verificar que no se tiene ningun cluster de docker swarm podemos correr el comando
---> docker node ls
Nos mostrara un error que dice que no es un nodo manager o no se ha iniciado el cluster.
Entonces para iniciar el cluster de docker swarm colocamos el siguiente comando
---> vagrant@manager ~ $ docker swarm init --advertise-addr 192.168.1.1:2377
Nos mostrata algo similar a esto
#------------------------------
vagrant@manager ~ $ docker swarm init --advertise-addr 192.168.1.1:2377
Swarm initialized: current node (5lcvr0v43s4nw9n184nii0kju) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join \
    --token SWMTKN-1-3z7u2vdz1ut2wfd590ipyvrbkjjqzfrjimpk9r2tv99f38alyk-9vc2sn9607ej6hqi287v3n105 \
    192.168.1.1:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
#-----------------------------
Hasta este punto ya se tiene creado el cluster de docker swarm ahora solo tenemos que agregar los workers.
Para ello salimos de la VM manager e ingresamos via ssh a la maquina worker1.
---> vagrant ssh worker1
Ya estando dentro de la VM worker1
Procedemos unir el worker al cluster de docker con el siguiente comando, tomando en cuenta el comando anterior
--> vagrant@worker1 ~ $ docker swarm join --token SWMTKN-1-3z7u2vdz1ut2wfd590ipyvrbkjjqzfrjimpk9r2tv99f38alyk-9vc2sn9607ej6hqi287v3n105 
192.168.1.1:2377

Si nos damos cuenta el token que se ingresa es el anterior que nos mostro al iniciar el cluster en la VM manager.
Hasta este punto ya se tiene configurado el cluster de docker swarm y se tiene agregado al mismo el worker.
Para verificar esto, podemos salir de la VM worker y voler a ingresar a la VM manager.
--> vagrant ssh manager
Y colocamos el comando  y nos muestra el cluster que se realizo con los nodos workers agregados. 
--->vagrant@manager ~ $ docker node ls
ID                           HOSTNAME   STATUS  AVAILABILITY  MANAGER STATUS
046ntx15ugx1z78kbwvc3wfup    localhost  Ready   Active
5lcvr0v43s4nw9n184nii0kju *  localhost  Ready   Active        Leader