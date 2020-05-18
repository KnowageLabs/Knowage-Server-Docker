ARG JAVA_VERSION=8
FROM openjdk:${JAVA_VERSION}

ARG KNOWAGE_VERSION="7_1_0"
ARG KNOWAGE_REPO_VERSION="7.1.0"
ARG KNOWAGE_EDITION="CE"
ARG KNOWAGE_RELEASE_DATE="20191230"
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
ARG KNOWAGE_QBE_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_QBE_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_SVGVIEWER_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_SVGVIEWER_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_TALEND_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_TALEND_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_WHATIF_URL="${KNOWAGE_OW2_BASE_URL}/${KNOWAGE_WHATIF_ENGINE}-${KNOWAGE_PACKAGE_SUFFIX}${FILEEXTENSION}"
ARG KNOWAGE_MYSQL_SCRIPT_URL="${KNOWAGE_OW2_DDL_URL}/mysql-dbscripts-${KNOWAGE_VERSION}-${KNOWAGE_RELEASE_DATE}.zip"

# Apache Tomcat
ARG APACHE_TOMCAT_VERSION="8.5.37"
ENV APACHE_TOMCAT_PACKAGE apache-tomcat-${APACHE_TOMCAT_VERSION}
ARG APACHE_TOMCAT_URL="https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.37/bin/${APACHE_TOMCAT_PACKAGE}.zip"

# Knowage deps
ARG LIB_COMMONS_LOGGING_NAME="commons-logging-1.1.1.jar"
ARG LIB_COMMONS_LOGGING_URL="https://search.maven.org/remotecontent?filepath=commons-logging/commons-logging/1.1.1/${LIB_COMMONS_LOGGING_NAME}"
ARG LIB_COMMONS_LOGGING_API_NAME="commons-logging-api-1.1.jar"
ARG LIB_COMMONS_LOGGING_API_URL="https://search.maven.org/remotecontent?filepath=commons-logging/commons-logging-api/1.1/${LIB_COMMONS_LOGGING_API_NAME}"
ARG LIB_CONCURRENT_NAME="oswego-concurrent-1.3.4.jar"
ARG LIB_CONCURRENT_URL="https://search.maven.org/remotecontent?filepath=org/lucee/oswego-concurrent/1.3.4/${LIB_CONCURRENT_NAME}"
ARG LIB_MYSQL_CONNECTOR_NAME="mysql-connector-java-5.1.33.jar"
ARG LIB_MYSQL_CONNECTOR_URL="https://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/5.1.33/${LIB_MYSQL_CONNECTOR_NAME}"
ARG LIB_GERONIMO_COMMONJ_NAME="geronimo-commonj_1.1_spec-1.0.jar"
ARG LIB_GERONIMO_COMMONJ_URL="https://search.maven.org/remotecontent?filepath=org/apache/geronimo/specs/geronimo-commonj_1.1_spec/1.0/${LIB_GERONIMO_COMMONJ_NAME}"
ARG LIB_MYFOO_COMMONJ_NAME="commonj-1.0.jar"
ARG LIB_MYFOO_COMMONJ_URL="https://github.com/SpagoBILabs/SpagoBI/blob/mvn-repo/releases/de/myfoo/commonj/1.0/${LIB_MYFOO_COMMONJ_NAME}?raw=true"
ARG LIB_POSTGRESQL_CONNECTOR_NAME="postgresql-42.2.4.jar"
ARG LIB_POSTGRESQL_CONNECTOR_URL="https://jdbc.postgresql.org/download/${LIB_POSTGRESQL_CONNECTOR_NAME}"

# Knowage home directory
ENV KNOWAGE_DIRECTORY /home/knowage

# MySql script directory
ENV MYSQL_SCRIPT_DIRECTORY ${KNOWAGE_DIRECTORY}/mysql

WORKDIR ${KNOWAGE_DIRECTORY}

# Install required packages and clean up to save space
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y wget -q coreutils unzip default-mysql-client \
	&& rm -rf /var/lib/apt/lists/*

# Download MySql scripts
RUN wget -q "${KNOWAGE_MYSQL_SCRIPT_URL}" -O mysql.zip \
	&& unzip mysql.zip \
	&& rm mysql.zip

# Download Apache Tomcat and extract it
RUN wget -q "${APACHE_TOMCAT_URL}" \
	&& unzip ${APACHE_TOMCAT_PACKAGE}.zip \
	&& rm ${APACHE_TOMCAT_PACKAGE}.zip

WORKDIR ${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}/webapps

# Download Knowage engines and extract them
RUN wget -O temp.zip "${KNOWAGE_CORE_URL}" \
	&& unzip temp.zip *.war \
	&& unzip ${KNOWAGE_CORE_ENGINE}.war -d ${KNOWAGE_CORE_ENGINE} \
	&& rm ${KNOWAGE_CORE_ENGINE}.war \
	&& rm temp.zip \
	&& wget -O temp.zip "${KNOWAGE_BIRTREPORT_URL}" \
	&& unzip temp.zip *.war \
	&& unzip ${KNOWAGE_BIRTREPORT_ENGINE}.war -d ${KNOWAGE_BIRTREPORT_ENGINE} \
	&& rm ${KNOWAGE_BIRTREPORT_ENGINE}.war \
	&& rm temp.zip \
	&& wget -O temp.zip "${KNOWAGE_COCKPIT_URL}" \
	&& unzip temp.zip *.war \
	&& unzip ${KNOWAGE_COCKPIT_ENGINE}.war -d ${KNOWAGE_COCKPIT_ENGINE} \
	&& rm ${KNOWAGE_COCKPIT_ENGINE}.war \
	&& rm temp.zip \
	&& wget -O temp.zip "${KNOWAGE_COMMONJ_URL}" \
	&& unzip temp.zip *.war \
	&& unzip ${KNOWAGE_COMMONJ_ENGINE}.war -d ${KNOWAGE_COMMONJ_ENGINE} \
	&& rm ${KNOWAGE_COMMONJ_ENGINE}.war \
	&& rm temp.zip \
	&& wget -O temp.zip "${KNOWAGE_DATAMINING_URL}" \
	&& unzip temp.zip *.war \
	&& unzip ${KNOWAGE_DATAMINING_ENGINE}.war -d ${KNOWAGE_DATAMINING_ENGINE} \
	&& rm ${KNOWAGE_DATAMINING_ENGINE}.war \
	&& rm temp.zip \
	&& wget -O temp.zip "${KNOWAGE_GEOREPORT_URL}" \
	&& unzip temp.zip *.war \
	&& unzip ${KNOWAGE_GEOREPORT_ENGINE}.war -d ${KNOWAGE_GEOREPORT_ENGINE} \
	&& rm ${KNOWAGE_GEOREPORT_ENGINE}.war \
	&& rm temp.zip \
	&& wget -O temp.zip "${KNOWAGE_JASPERREPORT_URL}" \
	&& unzip temp.zip *.war \
	&& unzip ${KNOWAGE_JASPERREPORT_ENGINE}.war -d ${KNOWAGE_JASPERREPORT_ENGINE} \
	&& rm ${KNOWAGE_JASPERREPORT_ENGINE}.war \
	&& rm temp.zip \
	&& wget -O temp.zip "${KNOWAGE_KPI_URL}" \
	&& unzip temp.zip *.war \
	&& unzip ${KNOWAGE_KPI_ENGINE}.war -d ${KNOWAGE_KPI_ENGINE} \
	&& rm ${KNOWAGE_KPI_ENGINE}.war \
	&& rm temp.zip \
	&& wget -O temp.zip "${KNOWAGE_META_URL}" \
	&& unzip temp.zip *.war \
	&& unzip ${KNOWAGE_META_ENGINE}.war -d ${KNOWAGE_META_ENGINE} \
	&& rm ${KNOWAGE_META_ENGINE}.war \
	&& rm temp.zip \
	&& wget -O temp.zip "${KNOWAGE_QBE_URL}" \
	&& unzip temp.zip *.war \
	&& unzip ${KNOWAGE_QBE_ENGINE}.war -d ${KNOWAGE_QBE_ENGINE} \
	&& rm ${KNOWAGE_QBE_ENGINE}.war \
	&& rm temp.zip \
	&& wget -O temp.zip "${KNOWAGE_SVGVIEWER_URL}" \
	&& unzip temp.zip *.war \
	&& unzip ${KNOWAGE_SVGVIEWER_ENGINE}.war -d ${KNOWAGE_SVGVIEWER_ENGINE} \
	&& rm ${KNOWAGE_SVGVIEWER_ENGINE}.war \
	&& rm temp.zip \
	&& wget -O temp.zip "${KNOWAGE_TALEND_URL}" \
	&& unzip temp.zip *.war \
	&& unzip ${KNOWAGE_TALEND_ENGINE}.war -d ${KNOWAGE_TALEND_ENGINE} \
	&& rm ${KNOWAGE_TALEND_ENGINE}.war \
	&& rm temp.zip \
	&& wget -O temp.zip "${KNOWAGE_WHATIF_URL}" \
	&& unzip temp.zip *.war \
	&& unzip ${KNOWAGE_WHATIF_ENGINE}.war -d ${KNOWAGE_WHATIF_ENGINE} \
	&& rm ${KNOWAGE_WHATIF_ENGINE}.war \
	&& rm temp.zip

WORKDIR ${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}/lib

# Download Knowage libs and put them into Apache Tomcat lib
RUN wget -O "${LIB_COMMONS_LOGGING_NAME}" -q "${LIB_COMMONS_LOGGING_URL}"
RUN wget -O "${LIB_COMMONS_LOGGING_API_NAME}" -q "${LIB_COMMONS_LOGGING_API_URL}"
RUN wget -O "${LIB_CONCURRENT_NAME}" -q "${LIB_CONCURRENT_URL}"
RUN wget -O "${LIB_MYSQL_CONNECTOR_NAME}" -q "${LIB_MYSQL_CONNECTOR_URL}"
RUN wget -O "${LIB_GERONIMO_COMMONJ_NAME}" -q "${LIB_GERONIMO_COMMONJ_URL}"
RUN wget -O "${LIB_MYFOO_COMMONJ_NAME}" -q "${LIB_MYFOO_COMMONJ_URL}"
RUN wget -O "${LIB_POSTGRESQL_CONNECTOR_NAME}" -q "${LIB_POSTGRESQL_CONNECTOR_URL}"

WORKDIR ${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}/conf

# Override Apache Tomcat server configuration
COPY server.xml ./

# Copy Knowage Security Policy
COPY knowage-default.policy ./

WORKDIR ${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}/bin

#make the script executable by bash (not only sh) and
#make knowage running forever without exiting when running the container
RUN sed -i "s/bin\/sh/bin\/bash/" startup.sh && \
	sed -i "s/EXECUTABLE\" start/EXECUTABLE\" run/" startup.sh

# Enable Security Manager
RUN echo "export JAVA_OPTS=\"\$JAVA_OPTS -Djava.security.manager -Djava.security.policy=\$CATALINA_HOME/conf/knowage-default.policy\"" >> setenv.sh

#copy entrypoint to be used at runtime
COPY ./entrypoint.sh ./ \
	./wait-for-it.sh ./

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
