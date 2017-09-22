#Download base image ubuntu 16.04
#FROM ubuntu:16.04
FROM mysql:5.7
#FROM java:openjdk-8

RUN systemctl status mysql.service
RUN mysqladmin -p root -u root version

ENV MYSQL_ROOT_PASSWORD=root

ENV KNOWAGE_VERSION=6_0_0-CE-Installer-Unix
ENV KNOWAGE_RELEASE_DATE=20170921
ENV KNOWAGE_URL=http://download.forge.ow2.org/knowage/Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.zip
ENV KNOWAGE_MYSQL_SCRIPT_URL=http://download.forge.ow2.org/knowage/mysql-dbscripts-6.0.0_20170616.zip

ENV KNOWAGE_DIRECTORY /home/knowage
ENV MYSQL_SCRIPT_DIRECTORY ${KNOWAGE_DIRECTORY}/mysql
WORKDIR ${KNOWAGE_DIRECTORY}

#RUN ["/bin/bash", "-c", "debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'"]
#RUN ["/bin/bash", "-c", "debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'"]
RUN apt-get update && apt-get -y install wget coreutils default-jre unzip && rm -rf /var/lib/apt/lists/*

RUN ls /usr/lib/jvm/

#download knowage and extract it
#RUN wget "${KNOWAGE_URL}" && \
#       unzip Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.zip && \
#       rm Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.zip

#download mysql scripts
RUN wget "${KNOWAGE_MYSQL_SCRIPT_URL}" -O mysql.zip && \
        unzip mysql.zip && \
        rm mysql.zip

COPY ./entrypoint.sh ./
COPY ./default_params.properties ./

#make all scripts executable
RUN chmod +x *.sh

#Install Knowage via installer and default params
#RUN ["/bin/bash", "-c", "./Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.sh -q -varfile default_params.properties"]

EXPOSE 8080
#-d option is passed to run knowage forever without exiting from container
ENTRYPOINT ["./entrypoint.sh"]

WORKDIR ${KNOWAGE_DIRECTORY}/Knowage-Server-CE/bin

CMD ["startup.sh"]
