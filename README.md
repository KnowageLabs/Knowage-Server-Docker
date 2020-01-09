# Docker Image for Knowage

[![Docker badge](https://img.shields.io/docker/pulls/knowagelabs/knowage-server-docker.svg)](https://hub.docker.com/r/knowagelabs/knowage-server-docker/)

## What is Knowage?

Knowage is the professional open source suite for modern business analytics over traditional sources and big data systems.

> [knowage-suite.com](https://www.knowage-suite.com)

## Run Knowage

Differently from its predecessor (i.e. SpagoBI), you can use ```docker-compose``` or ```Docker Swarm``` for running Knowage with a MySQL container. This will be shipped with within a single command.

Both ways need to be defined by a simple text file in [YAML](https://docs.docker.com/compose/compose-file/) format that describes which containers must be run.

Pay attention that for both YAML files in this project, the DBMS stores its data in a volume called ```db``` to make them permanent between multiple run of the DBMS. If you want to reset DB data you need to delete that volume.

### Use docker-compose

If you want to run Knowage on your local machine, with minimum configuration, for testing purpose, run this command inside the folder with ```docker-compose.yml``` file:

```console
$ docker-compose up
```

This launch the DBMS and Knowage in attached mode: here you can see logs of both the container at the same time. To stop both containers you can use ```CTRL+C```. If you want to run Knowage in detached mode use ```-d``` option like:

```console
$ docker-compose up -d
```

If you want to remove all the containers that Knowage created, just use:

```console
$ docker-compose down
```

In that case, you can also use ```-v``` option to delete all the data of the DBMS that are stored the the relative volume.

### Use Docker Swarm

If you want to run Knowage in a Docker Swarm cluster, with the ability to scale up the main app or the DB, to create complex deployment configuration or to enhance the security with Docker Secrets, run this command inside the folder with ```docker-swarm.yml``` file:

```console
$ docker stack deploy -c docker-swarm.yml knowage
```

If you want to stop Knowage and remove all created containers, you can use:

```console
$ docker stack rm
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
    image: knowagelabs/knowage-server-docker:7.1
    ports:
      - "8080:8080"
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

By default, Knowage run its container on the port ```8080/tcp```, as you can see from the sample YAML files. If you set your ```PUBLIC_ADDRESS``` environment to ```localhost``` or ```127.0.0.1```, you can point your browser to:

> http://localhost:8080/knowage

And you could see the login page of Knowage. If this hot happens you have to check Docker configuration to see on what network interface container ports are exposed: by default, Docker should use all network interfaces on the host (the IP ```0.0.0.0``` means all interface).

If you need to expose ports only on a specific ip, you need to add it to ports declaration like:

```console
version: "3.1"
services:
  knowage:
    image: knowagelabs/knowage-server-docker:7.1
    ports:
      - "127.0.0.1:8080:8080"
    ...
```

By default, the available users are:

|User   |Password|
|-------|--------|
|biadmin|biadmin |
|bidev  |bidev   |
|biuser |biuser  |

## License

View license information [here](https://github.com/KnowageLabs/Knowage-Server/) for the software contained in this image.

## How to contribute

Before start to contribute, please read and sign the [Contributor License Agreement](https://www.clahub.com/agreements/KnowageLabs/Knowage-Server-Docker).
The contribution process is based on GitHub pull requests (https://help.github.com/articles/about-pull-requests/).
