FROM mysql:5.7

# Environment variables
ENV KNOWAGE_VERSION=6_0_0-CE-Installer-Unix
ENV KNOWAGE_RELEASE_DATE=20170921
ENV KNOWAGE_URL=http://download.forge.ow2.org/knowage/Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.zip
ENV TOMCAT_DIRECTORY=Knowage-Server-CE
ENV KNOWAGE_MYSQL_SCRIPT_URL=http://download.forge.ow2.org/knowage/mysql-dbscripts-6.0.0_20170616.zip

ENV KNOWAGE_DIRECTORY /home/knowage
ENV MYSQL_SCRIPT_DIRECTORY ${KNOWAGE_DIRECTORY}/mysql
WORKDIR ${KNOWAGE_DIRECTORY}

RUN apt-get update && apt-get -y install wget coreutils unzip default-jre && rm -rf /var/lib/apt/lists/*

#download knowage and extract it
RUN wget "${KNOWAGE_URL}" && \
       unzip Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.zip && \
       rm Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.zip
       
#make all scripts executable
RUN chmod +x *.sh

#download mysql scripts
RUN wget "${KNOWAGE_MYSQL_SCRIPT_URL}" -O mysql.zip && \
        unzip mysql.zip && \
        rm mysql.zip

COPY ./default_params.properties ./

#Install Knowage via installer and default params
RUN ["/bin/bash", "-c", "/etc/init.d/mysql start &&  mysql -u root -e 'USE mysql; UPDATE `user` SET `Host`=\"%\", `plugin`=\"mysql_native_password\"  WHERE `User`=\"root\" AND `Host`=\"localhost\"; DELETE FROM `user` WHERE `Host` != \"%\" AND `User`=\"root\"; FLUSH PRIVILEGES;' && ./Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.sh -q -console -Dinstall4j.debug=true -Dinstall4j.keepLog=true -Dinstall4j.logToStderr=true -Dinstall4j.detailStdout=true -varfile default_params.properties"]

RUN ls ${KNOWAGE_DIRECTORY}/${TOMCAT_DIRECTORY}

WORKDIR ${KNOWAGE_DIRECTORY}/${TOMCAT_DIRECTORY}/bin
COPY ./entrypoint.sh ./

#make all scripts executable
RUN chmod +x *.sh

EXPOSE 8080
#-d option is passed to run knowage forever without exiting from container
ENTRYPOINT ["./entrypoint.sh"]

CMD ["./startup.sh"]
