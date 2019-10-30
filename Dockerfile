ARG JAVA_VERSION=8
FROM openjdk:${JAVA_VERSION}

ARG KNOWAGE_VERSION="6_4_0"
ARG KNOWAGE_REPO_VERSION="6.4.0"
ARG KNOWAGE_EDITION="CE"
ARG KNOWAGE_RELEASE_DATE="20190509"
ARG KNOWAGE_PACKAGE_SUFFIX="bin-${KNOWAGE_VERSION}-${KNOWAGE_EDITION}-${KNOWAGE_RELEASE_DATE}"
ARG FILEEXTENSION=".zip"
ARG KNOWAGE_OW2_BASE_URL="http://release.ow2.org/knowage/${KNOWAGE_REPO_VERSION}/Applications"
ARG KNOWAGE_OW2_DDL_URL="http://release.ow2.org/knowage/${KNOWAGE_REPO_VERSION}/Database%20scripts"


ARG  KNOWAGE_CORE_ENGINE="knowage"
ARG  KNOWAGE_BIRTREPORT_ENGINE="${KNOWAGE_CORE_ENGINE}birtreportengine"
ARG  KNOWAGE_COCKPIT_ENGINE="${KNOWAGE_CORE_ENGINE}cockpitengine"
ARG  KNOWAGE_COMMONJ_ENGINE="${KNOWAGE_CORE_ENGINE}commonjengine"
ARG  KNOWAGE_DATAMINING_ENGINE="${KNOWAGE_CORE_ENGINE}dataminingengine"
ARG  KNOWAGE_GEOREPORT_ENGINE="${KNOWAGE_CORE_ENGINE}georeportengine"
ARG  KNOWAGE_JASPERREPORT_ENGINE="${KNOWAGE_CORE_ENGINE}jasperreportengine"
ARG  KNOWAGE_KPI_ENGINE="${KNOWAGE_CORE_ENGINE}kpiengine"
ARG  KNOWAGE_META_ENGINE="${KNOWAGE_CORE_ENGINE}meta"
ARG  KNOWAGE_NETWORK_ENGINE="${KNOWAGE_CORE_ENGINE}networkengine"
ARG  KNOWAGE_QBE_ENGINE="${KNOWAGE_CORE_ENGINE}qbeengine"
ARG  KNOWAGE_SVGVIEWER_ENGINE="${KNOWAGE_CORE_ENGINE}svgviewerengine"
ARG  KNOWAGE_TALEND_ENGINE="${KNOWAGE_CORE_ENGINE}talendengine"
ARG  KNOWAGE_WHATIF_ENGINE="${KNOWAGE_CORE_ENGINE}whatifengine"
 
ARG KNOWAGE_CORE_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_CORE_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_BIRTREPORT_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_BIRTREPORT_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_COCKPIT_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_COCKPIT_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_COMMONJ_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_COMMONJ_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_DATAMINING_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_DATAMINING_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_GEOREPORT_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_GEOREPORT_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_JASPERREPORT_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_JASPERREPORT_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_KPI_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_KPI_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_META_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_META_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_NETWORK_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_NETWORK_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_QBE_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_QBE_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_SVGVIEWER_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_SVGVIEWER_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_TALEND_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_TALEND_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_WHATIF_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_WHATIF_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_MYSQL_SCRIPT_URL="${KNOWAGE_OW2_DDL_URL}/mysql-dbscripts-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.zip"

ENV APACHE_TOMCAT_VERSION 8.5.37
ENV APACHE_TOMCAT_PACKAGE apache-tomcat-${APACHE_TOMCAT_VERSION}
ENV APACHE_TOMCAT_URL https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.37/bin/${APACHE_TOMCAT_PACKAGE}.zip

#location of mysql script to init knowage db

ENV LIB_COMMONS_LOGGING_URL https://search.maven.org/remotecontent?filepath=commons-logging/commons-logging/1.1.1/commons-logging-1.1.1.jar
ENV LIB_COMMONS_LOGGING_API_URL https://search.maven.org/remotecontent?filepath=commons-logging/commons-logging-api/1.1/commons-logging-api-1.1.jar
ENV LIB_CONCURRENT_URL https://search.maven.org/remotecontent?filepath=org/lucee/oswego-concurrent/1.3.4/oswego-concurrent-1.3.4.jar
ENV LIB_MYSQL_CONNECTOR_URL https://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/5.1.33/mysql-connector-java-5.1.33.jar
ENV LIB_GERONIMO_COMMONJ_URL https://search.maven.org/remotecontent?filepath=org/apache/geronimo/specs/geronimo-commonj_1.1_spec/1.0/geronimo-commonj_1.1_spec-1.0.jar
ENV LIB_MYFOO_COMMONJ_URL https://github.com/SpagoBILabs/SpagoBI/blob/mvn-repo/releases/de/myfoo/commonj/1.0/commonj-1.0.jar?raw=true

ENV LIB_POSTGRESQL_CONNECTOR_URL https://jdbc.postgresql.org/download/postgresql-42.2.4.jar

#knowage directory
ENV KNOWAGE_DIRECTORY /home/knowage
#mysql script directory
ENV MYSQL_SCRIPT_DIRECTORY ${KNOWAGE_DIRECTORY}/mysql

#go to knowage home directory
WORKDIR ${KNOWAGE_DIRECTORY}

#install required packages and clean up to save space
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget coreutils unzip mysql-client  && rm -rf /var/lib/apt/lists/*

#download mysql scripts
RUN wget "${KNOWAGE_MYSQL_SCRIPT_URL}" -O mysql.zip && \
        unzip mysql.zip && \
        rm mysql.zip

#download apache tomcat and extract it
RUN wget "${APACHE_TOMCAT_URL}" && \
       unzip ${APACHE_TOMCAT_PACKAGE}.zip && \
       rm ${APACHE_TOMCAT_PACKAGE}.zip

#go to apache tomcat webapps directory
WORKDIR ${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}/webapps

#download knowage engines and extract them
RUN    wget -O temp.zip "${KNOWAGE_CORE_URL}"         && unzip temp.zip *.war && unzip ${KNOWAGE_CORE_ENGINE}.war         -d ${KNOWAGE_CORE_ENGINE}         && rm ${KNOWAGE_CORE_ENGINE}.war         && rm temp.zip && \
       wget -O temp.zip "${KNOWAGE_BIRTREPORT_URL}"   && unzip temp.zip *.war && unzip ${KNOWAGE_BIRTREPORT_ENGINE}.war   -d ${KNOWAGE_BIRTREPORT_ENGINE}   && rm ${KNOWAGE_BIRTREPORT_ENGINE}.war   && rm temp.zip && \
       wget -O temp.zip "${KNOWAGE_COCKPIT_URL}"      && unzip temp.zip *.war && unzip ${KNOWAGE_COCKPIT_ENGINE}.war      -d ${KNOWAGE_COCKPIT_ENGINE}      && rm ${KNOWAGE_COCKPIT_ENGINE}.war      && rm temp.zip && \
       wget -O temp.zip "${KNOWAGE_COMMONJ_URL}"      && unzip temp.zip *.war && unzip ${KNOWAGE_COMMONJ_ENGINE}.war      -d ${KNOWAGE_COMMONJ_ENGINE}      && rm ${KNOWAGE_COMMONJ_ENGINE}.war      && rm temp.zip && \
       wget -O temp.zip "${KNOWAGE_DATAMINING_URL}"   && unzip temp.zip *.war && unzip ${KNOWAGE_DATAMINING_ENGINE}.war   -d ${KNOWAGE_DATAMINING_ENGINE}   && rm ${KNOWAGE_DATAMINING_ENGINE}.war   && rm temp.zip && \
       wget -O temp.zip "${KNOWAGE_GEOREPORT_URL}"    && unzip temp.zip *.war && unzip ${KNOWAGE_GEOREPORT_ENGINE}.war    -d ${KNOWAGE_GEOREPORT_ENGINE}    && rm ${KNOWAGE_GEOREPORT_ENGINE}.war    && rm temp.zip && \
       wget -O temp.zip "${KNOWAGE_JASPERREPORT_URL}" && unzip temp.zip *.war && unzip ${KNOWAGE_JASPERREPORT_ENGINE}.war -d ${KNOWAGE_JASPERREPORT_ENGINE} && rm ${KNOWAGE_JASPERREPORT_ENGINE}.war && rm temp.zip && \
       wget -O temp.zip "${KNOWAGE_KPI_URL}"          && unzip temp.zip *.war && unzip ${KNOWAGE_KPI_ENGINE}.war          -d ${KNOWAGE_KPI_ENGINE}          && rm ${KNOWAGE_KPI_ENGINE}.war          && rm temp.zip && \
       wget -O temp.zip "${KNOWAGE_META_URL}"         && unzip temp.zip *.war && unzip ${KNOWAGE_META_ENGINE}.war         -d ${KNOWAGE_META_ENGINE}         && rm ${KNOWAGE_META_ENGINE}.war         && rm temp.zip && \
       wget -O temp.zip "${KNOWAGE_NETWORK_URL}"      && unzip temp.zip *.war && unzip ${KNOWAGE_NETWORK_ENGINE}.war      -d ${KNOWAGE_NETWORK_ENGINE}      && rm ${KNOWAGE_NETWORK_ENGINE}.war      && rm temp.zip && \
       wget -O temp.zip "${KNOWAGE_QBE_URL}"          && unzip temp.zip *.war && unzip ${KNOWAGE_QBE_ENGINE}.war          -d ${KNOWAGE_QBE_ENGINE}          && rm ${KNOWAGE_QBE_ENGINE}.war          && rm temp.zip && \
       wget -O temp.zip "${KNOWAGE_SVGVIEWER_URL}"    && unzip temp.zip *.war && unzip ${KNOWAGE_SVGVIEWER_ENGINE}.war    -d ${KNOWAGE_SVGVIEWER_ENGINE}    && rm ${KNOWAGE_SVGVIEWER_ENGINE}.war    && rm temp.zip && \
       wget -O temp.zip "${KNOWAGE_TALEND_URL}"       && unzip temp.zip *.war && unzip ${KNOWAGE_TALEND_ENGINE}.war       -d ${KNOWAGE_TALEND_ENGINE}       && rm ${KNOWAGE_TALEND_ENGINE}.war       && rm temp.zip && \
       wget -O temp.zip "${KNOWAGE_WHATIF_URL}"       && unzip temp.zip *.war && unzip ${KNOWAGE_WHATIF_ENGINE}.war       -d ${KNOWAGE_WHATIF_ENGINE}       && rm ${KNOWAGE_WHATIF_ENGINE}.war

#go to apache tomcat lib directory
WORKDIR ${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}/lib

#download knowage libs and put them into apache tomcat lib
RUN wget "${LIB_COMMONS_LOGGING_URL}"
RUN wget "${LIB_COMMONS_LOGGING_API_URL}"
RUN wget "${LIB_CONCURRENT_URL}"
RUN wget "${LIB_MYSQL_CONNECTOR_URL}"
RUN wget "${LIB_GERONIMO_COMMONJ_URL}"
RUN wget "${LIB_MYFOO_COMMONJ_URL}"

#dowload DBs libraries and put them into apache tomcat lib
RUN wget "${LIB_POSTGRESQL_CONNECTOR_URL}"

#go to apache tomcat configuration directory
WORKDIR ${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}/conf

#override apache tomcat server configuration
COPY server.xml ./

#go to binary folder in order to execute tomcat startup
WORKDIR ${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}/bin

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

#-d option is passed to run knowage forever without exiting from container
ENTRYPOINT ["./entrypoint.sh"]

#this will start knowage just after the previous entrypoint
CMD ["./startup.sh"]
