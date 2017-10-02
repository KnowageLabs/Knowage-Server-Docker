FROM java:8

ENV KNOWAGE_VERSION 6.0.0
ENV KNOWAGE_EDITION CE
ENV KNOWAGE_RELEASE_DATE 20170616
ENV KNOWAGE_PACKAGE_SUFFIX bin-${KNOWAGE_VERSION}-${KNOWAGE_EDITION}-${KNOWAGE_RELEASE_DATE}

ENV KNOWAGE_CORE_ENGINE knowage
ENV KNOWAGE_CORE_URL http://download.forge.ow2.org/knowage/${KNOWAGE_CORE_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

ENV KNOWAGE_BIRTREPORT_ENGINE ${KNOWAGE_CORE_ENGINE}birtreportengine
ENV KNOWAGE_BIRTREPORT_URL http://download.forge.ow2.org/knowage/${KNOWAGE_BIRTREPORT_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

ENV KNOWAGE_COCKPIT_ENGINE ${KNOWAGE_CORE_ENGINE}cockpitengine
ENV KNOWAGE_COCKPIT_URL http://download.forge.ow2.org/knowage/${KNOWAGE_COCKPIT_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

ENV KNOWAGE_COMMONJ_ENGINE ${KNOWAGE_CORE_ENGINE}commonjengine
ENV KNOWAGE_COMMONJ_URL http://download.forge.ow2.org/knowage/${KNOWAGE_COMMONJ_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

ENV KNOWAGE_DATAMINING_ENGINE ${KNOWAGE_CORE_ENGINE}dataminingengine
ENV KNOWAGE_DATAMINING_URL http://download.forge.ow2.org/knowage/${KNOWAGE_DATAMINING_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

ENV KNOWAGE_GEOREPORT_ENGINE ${KNOWAGE_CORE_ENGINE}georeportengine
ENV KNOWAGE_GEOREPORT_URL http://download.forge.ow2.org/knowage/${KNOWAGE_GEOREPORT_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

ENV KNOWAGE_JASPERREPORT_ENGINE ${KNOWAGE_CORE_ENGINE}jasperreportengine
ENV KNOWAGE_JASPERREPORT_URL http://download.forge.ow2.org/knowage/${KNOWAGE_JASPERREPORT_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

ENV KNOWAGE_KPI_ENGINE ${KNOWAGE_CORE_ENGINE}kpiengine
ENV KNOWAGE_KPI_URL http://download.forge.ow2.org/knowage/${KNOWAGE_KPI_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

ENV KNOWAGE_META_ENGINE ${KNOWAGE_CORE_ENGINE}meta
ENV KNOWAGE_META_URL http://download.forge.ow2.org/knowage/${KNOWAGE_META_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

ENV KNOWAGE_NETWORK_ENGINE ${KNOWAGE_CORE_ENGINE}networkengine
ENV KNOWAGE_NETWORK_URL http://download.forge.ow2.org/knowage/${KNOWAGE_NETWORK_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

ENV KNOWAGE_QBE_ENGINE ${KNOWAGE_CORE_ENGINE}qbeengine
ENV KNOWAGE_QBE_URL http://download.forge.ow2.org/knowage/${KNOWAGE_QBE_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

ENV KNOWAGE_SVGVIEWER_ENGINE ${KNOWAGE_CORE_ENGINE}svgviewerengine
ENV KNOWAGE_SVGVIEWER_URL http://download.forge.ow2.org/knowage/${KNOWAGE_SVGVIEWER_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

ENV KNOWAGE_TALEND_ENGINE ${KNOWAGE_CORE_ENGINE}talendengine
ENV KNOWAGE_TALEND_URL http://download.forge.ow2.org/knowage/${KNOWAGE_TALEND_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

ENV KNOWAGE_WHATIF_ENGINE ${KNOWAGE_CORE_ENGINE}whatifengine
ENV KNOWAGE_WHATIF_URL http://download.forge.ow2.org/knowage/${KNOWAGE_WHATIF_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

ENV APACHE_TOMCAT_VERSION 7.0.57
ENV APACHE_TOMCAT_PACKAGE apache-tomcat-${APACHE_TOMCAT_VERSION}
ENV APACHE_TOMCAT_URL https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.57/bin/${APACHE_TOMCAT_PACKAGE}.zip

# MySQL environment variables
ENV KNOWAGE_MYSQL_SCRIPT_URL=http://download.forge.ow2.org/knowage/mysql-dbscripts-${KNOWAGE_VERSION}_${KNOWAGE_RELEASE_DATE}.zip

ENV KNOWAGE_DIRECTORY /home/knowage
ENV MYSQL_SCRIPT_DIRECTORY ${KNOWAGE_DIRECTORY}/mysql

#go to knowage home directory
WORKDIR ${KNOWAGE_DIRECTORY}

RUN apt-get update && apt-get install -y wget coreutils unzip mysql-client  && rm -rf /var/lib/apt/lists/*

#download apache tomcat and extract it
RUN wget "${APACHE_TOMCAT_URL}" && \
       unzip ${APACHE_TOMCAT_PACKAGE}.zip && \
       rm ${APACHE_TOMCAT_PACKAGE}.zip

#download knowage engines and extract them
RUN wget "${KNOWAGE_CORE_URL}" && \
       unzip ${KNOWAGE_CORE_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip ${APACHE_TOMCAT_PACKAGE}/webapps && \
       rm ${KNOWAGE_CORE_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}.zip

#override apache tomcat server configuration
COPY server.xml ${APACHE_TOMCAT_PACKAGE}/conf/

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
