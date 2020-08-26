# Docker Image for Knowage R Service

[![Docker badge](https://img.shields.io/docker/pulls/knowagelabs/knowage-server-docker.svg)](https://hub.docker.com/r/knowagelabs/knowage-server-docker/)

## What is Knowage?

Knowage is the professional open source suite for modern business analytics over traditional sources and big data systems.

> [knowage-suite.com](https://www.knowage-suite.com)

## Run Knowage R Service

Knowage Python Service needs to be use with Knowage Server Docker.

### Environment variables

Knowage Python Service need a specific set of environment variables to correctly start:

* ```HMAC_KEY``` : *optional* - define the HMAC key that will bet set into Tomcat configuration; if not provided will be randomly generated.
* ```PUBLIC_ADDRESS``` : *optional* - define the IP Host of Knowage visible from outside the container (eg. ```http://$PUBLIC_ADDRESS:8080/knowage```),  the url's host part of Knowage URL. If not present (like the above examples) the default value is the IP of container. You can use the IP of virtual machine (in OSX or Windows environment) or localhost if you map the container's port.
* ```PUBLIC_ADDRESS``` : *optional* - define the IP Host of Knowage visible from outside the container (eg. ```http://$PUBLIC_ADDRESS:8080/knowage```),  the url's host part of Knowage URL. If not present (like the above examples) the default value is the IP of container. You can use the IP of virtual machine (in OSX or Windows environment) or localhost if you map the container's port.

## License

View license information [here](https://github.com/KnowageLabs/Knowage-Server/) for the software contained in this image.

## How to contribute

Before start to contribute, please read and sign the [Contributor License Agreement](https://www.clahub.com/agreements/KnowageLabs/Knowage-Server-Docker).
The contribution process is based on GitHub pull requests (https://help.github.com/articles/about-pull-requests/).
