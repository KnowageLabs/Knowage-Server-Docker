# Docker Image for Knowage

[![Docker badge](https://img.shields.io/docker/pulls/knowagelabs/knowage-server-docker.svg)](https://hub.docker.com/r/knowagelabs/knowage-server-docker/)

## What is Knowage?

Knowage is the professional open source suite for modern business analytics over traditional sources and big data systems.

> [knowage-suite.com](https://www.knowage-suite.com)

## Run Knowage

Differently from its predecessor (i.e. SpagoBI), you can use ```docker-compose``` or ```Docker Swarm``` for running Knowage with a MySQL container. This will be shipped with within a single command.

### Use docker-compose

Run this command inside the folder with ```docker-compose.yml``` file:

```console
$ docker-compose up
```

### Use Docker Swarm

Run this command inside the folder with ```docker-compose.yml``` file:

```console
$ docker stack deploy -c docker-swarm.yml knowage
```

### Environment variables

Knowage need a specific set of environment variables to correctly start.:

* ```DB_USER``` : *mandatory* - specify the DB user.
* ```DB_PASS``` : *mandatory* - specify the DB user's password.
* ```DB_ROOT_PASS``` : *mandatory* - set the root password of the DB.
* ```DB_DB``` : *mandatory* - specify the DB name.
* ```DB_HOST``` : *mandatory* - define the DB host.
* ```DB_PORT``` : *mandatory* - specify the DB port.
* ```HMAC_KEY``` : *mandatory* - define di HMAC key that will bet set into Tomcat configuration.
* ```PUBLIC_ADDRESS``` : *optional* - define the IP Host of Knowage visible from outside the container (eg. ```http://$PUBLIC_ADDRESS:8080/knowage```),  the url's host part of Knowage URL. If not present (like the above examples) the default value is the IP of container. You can use the IP of virtual machine (in OSX or Windows environment) or localhost if you map the container's port.

You can edit the file ```.env``` to set every variables you need.

### Docker secrets

If your run Knowage in a Docker Swarm, you may want to use secrets to define the value of the variables above. If you append ```_FILE``` to the name of the preceding environment variables you can specify the path of a Docker Secret that will be available to a running container.

For example, if you create the following secrets:

```console
$ printf "knowageuser"         | docker secret create knowage_db_user      -
$ printf "knowagepassword"     | docker secret create knowage_db_pass      -
$ printf "knowagedb"           | docker secret create knowage_db_host      -
$ printf "3306"                | docker secret create knowage_db_port      -
$ printf "knowagedb"           | docker secret create knowage_db_db        -
$ printf "knowagerootpassword" | docker secret create knowage_db_root_pass -
$ printf "abc123"              | docker secret create knowage_hmac_key     -
```

You can create a YAML file for Docker Swarm like:

```console
version: "3.1"
services:
  knowage:
    image: knowagelabs/knowage-server-docker:7.0
    ports:
      - "8080:8080"
    networks:
      - main
    environment:
      - DB_USER_FILE=/run/secrets/knowage_db_user
      - DB_PASS_FILE=/run/secrets/knowage_db_pass
      - DB_DB_FILE=/run/secrets/knowage_db_db
      - DB_HOST_FILE=/run/secrets/knowage_db_host
      - DB_PORT_FILE=/run/secrets/knowage_db_port
      - HMAC_KEY_FILE=/run/secrets/knowage_hmac_key
```

See ```docker-swarm.yml``` for an example.

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
