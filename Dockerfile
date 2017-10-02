FROM mysql:5.6

# Knowage environment variables
ENV KNOWAGE_VERSION=6_0_0-CE-Installer-Unix
ENV KNOWAGE_RELEASE_DATE=20170929
ENV KNOWAGE_URL=http://download.forge.ow2.org/knowage/Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.zip
ENV TOMCAT_DIRECTORY=Knowage-Server-CE
ENV KNOWAGE_DIRECTORY /home/knowage

# MySQL environment variables
ENV KNOWAGE_MYSQL_SCRIPT_URL=http://download.forge.ow2.org/knowage/mysql-dbscripts-6.0.0_20170616.zip
ENV MYSQL_SCRIPT_DIRECTORY ${KNOWAGE_DIRECTORY}/mysql

#change mysql data directory
RUN sed -i 's|/var/lib/mysql|/var/lib/mysql2|g' /etc/mysql/mysql.conf.d/mysqld.cnf
#RUN sed -i 's|/var/lib/mysql|/var/lib/mysql2|g' /etc/mysql/my.cnf

RUN apt-get update && apt-get -y install wget coreutils unzip default-jre && rm -rf /var/lib/apt/lists/*

#go to knowage home directory
WORKDIR ${KNOWAGE_DIRECTORY}

#add create database as first line and use database as second
#RUN sed -i '1s/^/USE knowage_ce;\n/' MySQL_create.sql
#RUN sed -i '1s/^/CREATE DATABASE knowage_ce;\n/' MySQL_create.sql
#RUN sed -i '1s/^/USE knowage_ce;\n/' MySQL_create_quartz_schema.sql
#RUN sed -i '1s/^/CREATE DATABASE knowage_ce;\n/' MySQL_create_quartz_schema.sql

#download knowage and extract it
RUN wget "${KNOWAGE_URL}" && \
       unzip Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.zip && \
       rm Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.zip
       
#make all scripts executable
RUN chmod +x *.sh

#set mysql data as volume, so that data while be kept at accross different runtimes
#VOLUME /var/lib/mysql

#copy the properties file which contains default answer for the unattended execution of the installer
COPY ./default_params.properties ./

#Install Knowage via installer using the default params
RUN ["/bin/bash", "-c", "/etc/init.d/mysql start &&  mysql -u root -e 'USE mysql; UPDATE `user` SET `Host`=\"%\", `plugin`=\"mysql_native_password\"  WHERE `User`=\"root\" AND `Host`=\"localhost\"; DELETE FROM `user` WHERE `Host` != \"%\" AND `User`=\"root\"; FLUSH PRIVILEGES;' && ./Knowage-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.sh -q -console -Dinstall4j.debug=true -Dinstall4j.keepLog=true -Dinstall4j.logToStderr=true -Dinstall4j.detailStdout=true -varfile default_params.properties && /etc/init.d/mysql stop"]

#download mysql scripts
#copy the scripts to init the db in the docker mysql entrypoint
#these will be used during the first run to init the db
#RUN wget "${KNOWAGE_MYSQL_SCRIPT_URL}" -O mysql.zip && \
#        unzip mysql.zip && \
#        rm mysql.zip && \
#	cp mysql/MySQL_create*.sql /docker-entrypoint-initdb.d/

#go to binary folder in order to execute tomcat startup
WORKDIR ${KNOWAGE_DIRECTORY}/${TOMCAT_DIRECTORY}/bin

#make the script executable by bash (not only sh) and
#make knowage running forever without exiting when running the container
RUN sed -i "s/bin\/sh/bin\/bash/" startup.sh && \
	sed -i "s/EXECUTABLE\" start/EXECUTABLE\" run/" startup.sh

#copy entrypoint to be used at runtime
COPY ./entrypoint.sh ./

#make all scripts executable
RUN chmod +x *.sh

#expose common tomcat port
#this can be used by the host to expose the application
#you can use it while running image with the param '-p 8080:8080'
EXPOSE 8080

#use -d option to run knowage forever without exiting from container
ENTRYPOINT ["./entrypoint.sh"]

#this will start knowage just after the previous entrypoint
CMD ["/etc/init.d/mysql start", "./startup.sh"]
