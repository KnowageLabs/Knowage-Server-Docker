FROM openjdk:8

ARG KNOWAGE_CORE_ENGINE="knowage"
ARG KNOWAGE_BIRTREPORT_ENGINE="${KNOWAGE_CORE_ENGINE}birtreportengine"
ARG KNOWAGE_COCKPIT_ENGINE="${KNOWAGE_CORE_ENGINE}cockpitengine"
ARG KNOWAGE_COMMONJ_ENGINE="${KNOWAGE_CORE_ENGINE}commonjengine"
ARG KNOWAGE_DATAMINING_ENGINE="${KNOWAGE_CORE_ENGINE}dataminingengine"
ARG KNOWAGE_GEOREPORT_ENGINE="${KNOWAGE_CORE_ENGINE}georeportengine"
ARG KNOWAGE_JASPERREPORT_ENGINE="${KNOWAGE_CORE_ENGINE}jasperreportengine"
ARG KNOWAGE_KPI_ENGINE="${KNOWAGE_CORE_ENGINE}kpiengine"
ARG KNOWAGE_META_ENGINE="${KNOWAGE_CORE_ENGINE}meta"
ARG KNOWAGE_QBE_ENGINE="${KNOWAGE_CORE_ENGINE}qbeengine"
ARG KNOWAGE_SVGVIEWER_ENGINE="${KNOWAGE_CORE_ENGINE}svgviewerengine"
ARG KNOWAGE_TALEND_ENGINE="${KNOWAGE_CORE_ENGINE}talendengine"
ARG KNOWAGE_WHATIF_ENGINE="${KNOWAGE_CORE_ENGINE}whatifengine"
ARG KNOWAGE_DATABASE_SCRIPT="${KNOWAGE_CORE_ENGINE}-database-scripts-mysql"

# Apache Tomcat
ARG APACHE_TOMCAT_VERSION="8.5.37"
ENV APACHE_TOMCAT_PACKAGE apache-tomcat-${APACHE_TOMCAT_VERSION}
ARG APACHE_TOMCAT_URL="https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.37/bin/${APACHE_TOMCAT_PACKAGE}.zip"

# Knowage dependencies
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
ARG LIB_HSQLDB_JDBC_DRIVER_NAME="hsqldb-1.8.0.10.jar"
ARG LIB_HSQLDB_JDBC_DRIVER_URL="https://search.maven.org/remotecontent?filepath=org/hsqldb/hsqldb/1.8.0.10/${LIB_HSQLDB_JDBC_DRIVER_NAME}"

# Knowage home directory
ENV KNOWAGE_DIRECTORY /home/knowage

# Tomcat sub-directories
ARG TOMCAT_HOME=${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}
ARG TOMCAT_BIN=${TOMCAT_HOME}/bin
ARG TOMCAT_CONF=${TOMCAT_HOME}/conf
ARG TOMCAT_LIB=${TOMCAT_HOME}/lib
ARG TOMCAT_WEBAPPS=${TOMCAT_HOME}/webapps

WORKDIR ${KNOWAGE_DIRECTORY}

# Copy common files
COPY CHANGELOG.md LICENSE  README.md entrypoint.sh wait-for-it.sh ./

# Install required packages and clean up to save space
RUN  apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y wget -q coreutils unzip mariadb-client-10.3 \
  && rm -rf /var/lib/apt/lists/*

# Download Apache Tomcat and extract it
RUN  wget -q "${APACHE_TOMCAT_URL}" \
  && unzip ${APACHE_TOMCAT_PACKAGE}.zip \
  && rm ${APACHE_TOMCAT_PACKAGE}.zip \
  && ln -s ${APACHE_TOMCAT_PACKAGE} apache-tomcat

# Add MySql scripts
COPY ${KNOWAGE_DATABASE_SCRIPT}.zip ./

RUN  unzip ${KNOWAGE_DATABASE_SCRIPT}.zip \
  && rm ${KNOWAGE_DATABASE_SCRIPT}.zip

ENV MYSQL_SCRIPT_DIRECTORY ${KNOWAGE_DIRECTORY}/mysql

# Add Knowage engines
COPY ${KNOWAGE_CORE_ENGINE}.war \
     ${KNOWAGE_BIRTREPORT_ENGINE}.war \
     ${KNOWAGE_COCKPIT_ENGINE}.war \
     ${KNOWAGE_COMMONJ_ENGINE}.war \
     ${KNOWAGE_DATAMINING_ENGINE}.war \
     ${KNOWAGE_GEOREPORT_ENGINE}.war \
     ${KNOWAGE_JASPERREPORT_ENGINE}.war \
     ${KNOWAGE_KPI_ENGINE}.war \
     ${KNOWAGE_META_ENGINE}.war \
     ${KNOWAGE_QBE_ENGINE}.war \
     ${KNOWAGE_SVGVIEWER_ENGINE}.war \
     ${KNOWAGE_TALEND_ENGINE}.war \
     ${KNOWAGE_WHATIF_ENGINE}.war \
     ./

RUN  unzip ${KNOWAGE_CORE_ENGINE}.war -d ${TOMCAT_WEBAPPS}/${KNOWAGE_CORE_ENGINE} \
  && rm ${KNOWAGE_CORE_ENGINE}.war \
  && unzip ${KNOWAGE_BIRTREPORT_ENGINE}.war -d ${TOMCAT_WEBAPPS}/${KNOWAGE_BIRTREPORT_ENGINE} \
  && rm ${KNOWAGE_BIRTREPORT_ENGINE}.war \
  && unzip ${KNOWAGE_COCKPIT_ENGINE}.war -d ${TOMCAT_WEBAPPS}/${KNOWAGE_COCKPIT_ENGINE} \
  && rm ${KNOWAGE_COCKPIT_ENGINE}.war \
  && unzip ${KNOWAGE_COMMONJ_ENGINE}.war -d ${TOMCAT_WEBAPPS}/${KNOWAGE_COMMONJ_ENGINE} \
  && rm ${KNOWAGE_COMMONJ_ENGINE}.war \
  && unzip ${KNOWAGE_DATAMINING_ENGINE}.war -d ${TOMCAT_WEBAPPS}/${KNOWAGE_DATAMINING_ENGINE} \
  && rm ${KNOWAGE_DATAMINING_ENGINE}.war \
  && unzip ${KNOWAGE_GEOREPORT_ENGINE}.war -d ${TOMCAT_WEBAPPS}/${KNOWAGE_GEOREPORT_ENGINE} \
  && rm ${KNOWAGE_GEOREPORT_ENGINE}.war \
  && unzip ${KNOWAGE_JASPERREPORT_ENGINE}.war -d ${TOMCAT_WEBAPPS}/${KNOWAGE_JASPERREPORT_ENGINE} \
  && rm ${KNOWAGE_JASPERREPORT_ENGINE}.war \
  && unzip ${KNOWAGE_KPI_ENGINE}.war -d ${TOMCAT_WEBAPPS}/${KNOWAGE_KPI_ENGINE} \
  && rm ${KNOWAGE_KPI_ENGINE}.war \
  && unzip ${KNOWAGE_META_ENGINE}.war -d ${TOMCAT_WEBAPPS}/${KNOWAGE_META_ENGINE} \
  && rm ${KNOWAGE_META_ENGINE}.war \
  && unzip ${KNOWAGE_QBE_ENGINE}.war -d ${TOMCAT_WEBAPPS}/${KNOWAGE_QBE_ENGINE} \
  && rm ${KNOWAGE_QBE_ENGINE}.war \
  && unzip ${KNOWAGE_SVGVIEWER_ENGINE}.war -d ${TOMCAT_WEBAPPS}/${KNOWAGE_SVGVIEWER_ENGINE} \
  && rm ${KNOWAGE_SVGVIEWER_ENGINE}.war \
  && unzip ${KNOWAGE_TALEND_ENGINE}.war -d ${TOMCAT_WEBAPPS}/${KNOWAGE_TALEND_ENGINE} \
  && rm ${KNOWAGE_TALEND_ENGINE}.war \
  && unzip ${KNOWAGE_WHATIF_ENGINE}.war -d ${TOMCAT_WEBAPPS}/${KNOWAGE_WHATIF_ENGINE} \
  && rm ${KNOWAGE_WHATIF_ENGINE}.war

# Download Knowage libs and put them into Apache Tomcat lib
RUN  wget -q -O "${TOMCAT_LIB}/${LIB_COMMONS_LOGGING_NAME}"      "${LIB_COMMONS_LOGGING_URL}"      \
  && wget -q -O "${TOMCAT_LIB}/${LIB_COMMONS_LOGGING_API_NAME}"  "${LIB_COMMONS_LOGGING_API_URL}"  \
  && wget -q -O "${TOMCAT_LIB}/${LIB_CONCURRENT_NAME}"           "${LIB_CONCURRENT_URL}"           \
  && wget -q -O "${TOMCAT_LIB}/${LIB_MYSQL_CONNECTOR_NAME}"      "${LIB_MYSQL_CONNECTOR_URL}"      \
  && wget -q -O "${TOMCAT_LIB}/${LIB_GERONIMO_COMMONJ_NAME}"     "${LIB_GERONIMO_COMMONJ_URL}"     \
  && wget -q -O "${TOMCAT_LIB}/${LIB_MYFOO_COMMONJ_NAME}"        "${LIB_MYFOO_COMMONJ_URL}"        \
  && wget -q -O "${TOMCAT_LIB}/${LIB_POSTGRESQL_CONNECTOR_NAME}" "${LIB_POSTGRESQL_CONNECTOR_URL}" \
  && wget -q -O "${TOMCAT_LIB}/${LIB_HSQLDB_JDBC_DRIVER_NAME}"   "${LIB_HSQLDB_JDBC_DRIVER_URL}"

# Override Apache Tomcat server configuration and add security policy
COPY server.xml knowage-default.policy ${TOMCAT_CONF}/

#make the script executable by bash (not only sh) and
#make knowage running forever without exiting when running the container
RUN  sed -i "s/bin\/sh/bin\/bash/"                   ${TOMCAT_BIN}/startup.sh \
  && sed -i "s/EXECUTABLE\" start/EXECUTABLE\" run/" ${TOMCAT_BIN}/startup.sh

# Enable Security Manager
RUN echo "export JAVA_OPTS=\"\$JAVA_OPTS -Djava.security.manager -Djava.security.policy=\$CATALINA_HOME/conf/knowage-default.policy\"" >> ${TOMCAT_BIN}/setenv.sh \
  && chmod +x ${TOMCAT_BIN}/*

# Expose common tomcat port
EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]

CMD ["./apache-tomcat/bin/startup.sh"]
