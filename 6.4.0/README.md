# Docker Image for Knowage

[![Docker badge](https://img.shields.io/docker/pulls/knowagelabs/knowage-server-docker.svg)](https://hub.docker.com/r/knowagelabs/knowage-server-docker/)

## What is Knowage?

Knowage is the professional open source suite for modern business analytics over traditional sources and big data systems.

> [knowage-suite.com](https://www.knowage-suite.com)
 
## Supported tags and respective Dockerfile links

* ```latest``` : [Dockerfile](https://raw.githubusercontent.com/KnowageLabs/Knowage-Server-Docker/master/6.3.3/Dockerfile)
* ```6.1.1``` : [Dockerfile](https://raw.githubusercontent.com/KnowageLabs/Knowage-Server-Docker/master/6.1.1/Dockerfile)
* ```6.2.0-RC``` : [Dockerfile](https://raw.githubusercontent.com/KnowageLabs/Knowage-Server-Docker/master/6.2.0-RC/Dockerfile)
* ```6.2.2``` : [Dockerfile](https://raw.githubusercontent.com/KnowageLabs/Knowage-Server-Docker/master/6.2.2/Dockerfile)
* ```develop``` : [Dockerfile](https://raw.githubusercontent.com/KnowageLabs/Knowage-Server-Docker/master/Dockerfile)

## Run Knowage

Differently from its predecessor (i.e. SpagoBI), you MUST uses ```docker-compose``` for running Knowage with a MySQL container. This will be shipped with within a single command.

### Supported tags and respective docker-compose links

* ```latest``` : [docker-compose](https://raw.githubusercontent.com/KnowageLabs/Knowage-Server-Docker/master/6.3.3/docker-compose.yml)
* ```6.1.1``` : [docker-compose](https://raw.githubusercontent.com/KnowageLabs/Knowage-Server-Docker/master/6.1.1/docker-compose.yml)
* ```6.2.0-RC``` : [docker-compose](https://raw.githubusercontent.com/KnowageLabs/Knowage-Server-Docker/master/6.2.0-RC/docker-compose.yml)
* ```6.2.2``` : [docker-compose](https://raw.githubusercontent.com/KnowageLabs/Knowage-Server-Docker/master/6.2.2/docker-compose.yml)
* ```develop``` : [docker-compose](https://raw.githubusercontent.com/KnowageLabs/Knowage-Server-Docker/master/docker-compose.yml)

### Use docker-compose

Run this command inside the folder with ```docker-compose.yml``` file:

```console
$ docker-compose up
```

### Properties

The only environment properties used by Knowage are:

* ```PUBLIC_ADDRESS``` : *optional* - define the IP Host of Knowage visible from outside the container (eg. ```http://$PUBLIC_ADDRESS:8080/knowage```),  the url's host part of Knowage URL. If not present (like the above examples) the default value is the IP of container. You can use the IP of virtual machine (in OSX or Windows environment) or localhost if you map the container's port.

## Use Knowage

Get the IP of container :

```console
$ docker inspect --format '{{ .NetworkSettings.IPAddress }}' knowage
172.17.0.43
```

Open Knowage on your browser at url (use your container-ip): 

> container-ip:8080/knowage

If you run the host with a Virtual Machine (for example in a Mac environment) then you can route the traffic directly to the container from you localhost using route command:

```console
$ sudo route -n add 172.17.0.0/16 ip-of-host-Virtual-Machine
```

Users available by default (username/password):

> biadmin/biadmin, bidev/bidev and biuser/biuser 

## License

View license information [here](https://github.com/KnowageLabs/Knowage-Server/) for the software contained in this image.
