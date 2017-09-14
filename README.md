# What is Knowage?

Knowage is the professional open source suite for modern business analytics over traditional sources and big data systems.

> [knowage-suite.com](https://www.knowage-suite.com)
 
# Supported tags and respective Dockerfile links

* ```latest``` : [Dockerfile](https://github.com/KnowageLabs/Knowage-Server-Docker/master/6.1/Dockerfile)
* ```6.1``` : [Dockerfile](https://github.com/SKnowageLabs/Knowage-Server/master/6.1/Dockerfile)
* ```develop``` : [Dockerfile](https://github.com/SKnowageLabs/Knowage-Server/master/Dockerfile)

# Run Knowage

Differently from its predecessor (i.e. SpagoBI), you MUST uses ```docker-compose``` for running Knowage with a MySQL container. This will be shipped with within a single command.

## Supported tags and respective docker-compose links

* ```latest``` : [docker-compose](https://github.com/KnowageLabs/Knowage-Server-Docker/master/6.1/docker-compose.yml)
* ```6.1``` : [docker-compose](https://github.com/SKnowageLabs/Knowage-Server/master/6.1/docker-compose.yml)
* ```develop``` : [docker-compose](https://github.com/SKnowageLabs/Knowage-Server/master/docker-compose.yml)

## Use docker-compose

Run this command inside the folder with ```docker-compose.yml``` file:

```console
$ docker-compose up
```

## Properties

The only two environment properties used by Knowage are:

* ```PUBLIC_ADDRESS``` : *optional* - define the IP Host of Knowage visible from outside the container (eg. ```http://$PUBLIC_ADDRESS:8080/knowage```),  the url's host part of Knowage URL. If not present (like the above examples) the default value is the IP of container. You can use the IP of virtual machine (in OSX or Windows environment) or localhost if you map the container's port.
* ```ENABLE_HIGHCHARTS``` : *optional* - define which library must be used to visualise data. Default option is *n* (i.e. ChartJS). Other options are *y* (i.e. Highcharts) and *demo* (i.e. Highcharts withe demo contents pre-installed).

# Use Knowage

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

# License

View license information [here](https://github.com/KnowageLabs/Knowage-Server/) for the software contained in this image.
