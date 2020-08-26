# Docker Image for Knowage Python Service

[![Docker badge](https://img.shields.io/docker/pulls/knowagelabs/knowage-server-docker.svg)](https://hub.docker.com/r/knowagelabs/knowage-server-docker/)

## What is Knowage?

Knowage is the professional open source suite for modern business analytics over traditional sources and big data systems.

> [knowage-suite.com](https://www.knowage-suite.com)

## Run Knowage Python Service

Knowage Python Service needs to be use with Knowage Server Docker.

### Environment variables

Knowage Python Service need a specific set of environment variables to correctly start:

* ```HMAC_KEY``` : *mandatory* - define the HMAC key that will bet used with Knowage-Server-Docker.
* ```KNOWAGE_PUBLIC_ADDRESS``` : *mandatory* - define the hostname of the instance of Knowage-Server-Docker.
* ```PUBLIC_ADDRESS``` : *mandatory* - define the hostname of the instance of Knowage-Python-Docker.

## License

View license information [here](https://github.com/KnowageLabs/Knowage-Server/) for the software contained in this image.
