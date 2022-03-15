FROM openjdk:8 AS init

# Knowage home directory
ENV KNOWAGE_DIRECTORY /home/knowage

# Apache Tomcat
ARG APACHE_TOMCAT_VERSION="9.0.60"
ENV APACHE_TOMCAT_PACKAGE apache-tomcat-${APACHE_TOMCAT_VERSION}
ARG APACHE_TOMCAT_URL="https://archive.apache.org/dist/tomcat/tomcat-9/v${APACHE_TOMCAT_VERSION}/bin/${APACHE_TOMCAT_PACKAGE}.zip"

# Tomcat sub-directories
ARG TOMCAT_HOME=${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}
ARG TOMCAT_BIN=${TOMCAT_HOME}/bin
ARG TOMCAT_CONF=${TOMCAT_HOME}/conf
ARG TOMCAT_CONF_CUSTOM_SERVER=${TOMCAT_HOME}/conf/server.xml.d
ARG TOMCAT_CONF_CUSTOM_CONTEXT=${TOMCAT_HOME}/conf/context.xml.d
ARG TOMCAT_LIB=${TOMCAT_HOME}/lib
ARG TOMCAT_WEBAPPS=${TOMCAT_HOME}/webapps
ARG TOMCAT_RESOURCES=${TOMCAT_HOME}/resources

# Knowage dependencies
ARG LIB_COMMONS_LOGGING_NAME="commons-logging-1.1.1.jar"
ARG LIB_COMMONS_LOGGING_URL="https://search.maven.org/remotecontent?filepath=commons-logging/commons-logging/1.1.1/${LIB_COMMONS_LOGGING_NAME}"
ARG LIB_COMMONS_LOGGING_API_NAME="commons-logging-api-1.1.jar"
ARG LIB_COMMONS_LOGGING_API_URL="https://search.maven.org/remotecontent?filepath=commons-logging/commons-logging-api/1.1/${LIB_COMMONS_LOGGING_API_NAME}"
ARG LIB_CONCURRENT_NAME="oswego-concurrent-1.3.4.jar"
ARG LIB_CONCURRENT_URL="https://search.maven.org/remotecontent?filepath=org/lucee/oswego-concurrent/1.3.4/${LIB_CONCURRENT_NAME}"
ARG LIB_MYSQL_CONNECTOR_NAME="mysql-connector-java-5.1.33.jar"
ARG LIB_MYSQL_CONNECTOR_URL="https://search.maven.org/remotecontent?filepath=mysql/mysql-connector-java/5.1.33/${LIB_MYSQL_CONNECTOR_NAME}"
ARG LIB_MARIADB_CONNECTOR_NAME="mariadb-java-client-2.7.2.jar"
ARG LIB_MARIADB_CONNECTOR_URL="https://search.maven.org/remotecontent?filepath=org/mariadb/jdbc/mariadb-java-client/2.7.2/${LIB_MARIADB_CONNECTOR_NAME}"
ARG LIB_GERONIMO_COMMONJ_NAME="geronimo-commonj_1.1_spec-1.0.jar"
ARG LIB_GERONIMO_COMMONJ_URL="https://search.maven.org/remotecontent?filepath=org/apache/geronimo/specs/geronimo-commonj_1.1_spec/1.0/${LIB_GERONIMO_COMMONJ_NAME}"
ARG LIB_MYFOO_COMMONJ_NAME="commonj-1.0.jar"
ARG LIB_MYFOO_COMMONJ_URL="https://github.com/SpagoBILabs/SpagoBI/blob/mvn-repo/releases/de/myfoo/commonj/1.0/${LIB_MYFOO_COMMONJ_NAME}?raw=true"
ARG LIB_POSTGRESQL_CONNECTOR_NAME="postgresql-42.2.4.jar"
ARG LIB_POSTGRESQL_CONNECTOR_URL="https://jdbc.postgresql.org/download/${LIB_POSTGRESQL_CONNECTOR_NAME}"
ARG LIB_HSQLDB_JDBC_DRIVER_NAME="hsqldb-1.8.0.10.jar"
ARG LIB_HSQLDB_JDBC_DRIVER_URL="https://search.maven.org/remotecontent?filepath=org/hsqldb/hsqldb/1.8.0.10/${LIB_HSQLDB_JDBC_DRIVER_NAME}"

ARG KNOWAGE_CORE_ENGINE="knowage"
ARG KNOWAGE_BIRTREPORT_ENGINE="${KNOWAGE_CORE_ENGINE}birtreportengine"
ARG KNOWAGE_COCKPIT_ENGINE="${KNOWAGE_CORE_ENGINE}cockpitengine"
ARG KNOWAGE_COMMONJ_ENGINE="${KNOWAGE_CORE_ENGINE}commonjengine"
ARG KNOWAGE_GEOREPORT_ENGINE="${KNOWAGE_CORE_ENGINE}georeportengine"
ARG KNOWAGE_JASPERREPORT_ENGINE="${KNOWAGE_CORE_ENGINE}jasperreportengine"
ARG KNOWAGE_KPI_ENGINE="${KNOWAGE_CORE_ENGINE}kpiengine"
ARG KNOWAGE_META_ENGINE="${KNOWAGE_CORE_ENGINE}meta"
ARG KNOWAGE_QBE_ENGINE="${KNOWAGE_CORE_ENGINE}qbeengine"
ARG KNOWAGE_SVGVIEWER_ENGINE="${KNOWAGE_CORE_ENGINE}svgviewerengine"
ARG KNOWAGE_TALEND_ENGINE="${KNOWAGE_CORE_ENGINE}talendengine"
ARG KNOWAGE_WHATIF_ENGINE="${KNOWAGE_CORE_ENGINE}whatifengine"
ARG KNOWAGE_API="${KNOWAGE_CORE_ENGINE}-api"
ARG KNOWAGE_VUE="${KNOWAGE_CORE_ENGINE}-vue"
ARG KNOWAGE_DATABASE_SCRIPT="${KNOWAGE_CORE_ENGINE}-database-scripts-mysql"

WORKDIR ${KNOWAGE_DIRECTORY}

# Download Apache Tomcat and extract it
RUN  wget -q "${APACHE_TOMCAT_URL}" \
  && unzip ${APACHE_TOMCAT_PACKAGE}.zip -x "*/webapps/manager/*" \
	"*/webapps/host-manager/*" \
	"*/webapps/examples/*" \
	"*/webapps/docs/*" \
	"*/webapps/ROOT/*"  \
  && rm ${APACHE_TOMCAT_PACKAGE}.zip \
  && ln -s ${APACHE_TOMCAT_PACKAGE} apache-tomcat \
  && mkdir ${TOMCAT_RESOURCES} ${TOMCAT_CONF_CUSTOM_SERVER} ${TOMCAT_CONF_CUSTOM_CONTEXT}

COPY setenv.sh ${TOMCAT_BIN}/
COPY server.xml context.xml knowage-default.policy hazelcast.xml ${TOMCAT_CONF}/
COPY services-whitelist.xml ${TOMCAT_RESOURCES}
COPY extGlobalResources ${TOMCAT_CONF_CUSTOM_SERVER}
COPY extContext ${TOMCAT_CONF_CUSTOM_CONTEXT}

# Install dependencies
RUN  apt-get update \
  && apt-get install -q --no-install-recommends -y unzip \
  && rm -rf /var/lib/apt/lists/*

# Add MySql scripts
COPY ${KNOWAGE_DATABASE_SCRIPT}.zip ./

# Extract database script
RUN  unzip ${KNOWAGE_DATABASE_SCRIPT}.zip "*create*" \
  && rm ${KNOWAGE_DATABASE_SCRIPT}.zip

# Add Knowage engines
COPY ${KNOWAGE_CORE_ENGINE}.war \
     ${KNOWAGE_BIRTREPORT_ENGINE}.war \
     ${KNOWAGE_COCKPIT_ENGINE}.war \
     ${KNOWAGE_COMMONJ_ENGINE}.war \
     ${KNOWAGE_GEOREPORT_ENGINE}.war \
     ${KNOWAGE_JASPERREPORT_ENGINE}.war \
     ${KNOWAGE_KPI_ENGINE}.war \
     ${KNOWAGE_META_ENGINE}.war \
     ${KNOWAGE_QBE_ENGINE}.war \
     ${KNOWAGE_SVGVIEWER_ENGINE}.war \
     ${KNOWAGE_TALEND_ENGINE}.war \
     ${KNOWAGE_WHATIF_ENGINE}.war \
     ${KNOWAGE_API}.war \
     ${KNOWAGE_VUE}.war \
     ${TOMCAT_WEBAPPS}/

# Expand WARs
RUN cd ${TOMCAT_WEBAPPS} && \
  for archive in *.war ; do unzip -d "$( basename "${archive%%.war}")" "$archive" ; rm ${archive} ; done

# Download Knowage libs and put them into Apache Tomcat lib
RUN  wget -q -O "${TOMCAT_LIB}/${LIB_COMMONS_LOGGING_NAME}"      "${LIB_COMMONS_LOGGING_URL}"      \
  && wget -q -O "${TOMCAT_LIB}/${LIB_COMMONS_LOGGING_API_NAME}"  "${LIB_COMMONS_LOGGING_API_URL}"  \
  && wget -q -O "${TOMCAT_LIB}/${LIB_CONCURRENT_NAME}"           "${LIB_CONCURRENT_URL}"           \
  && wget -q -O "${TOMCAT_LIB}/${LIB_MYSQL_CONNECTOR_NAME}"      "${LIB_MYSQL_CONNECTOR_URL}"      \
  && wget -q -O "${TOMCAT_LIB}/${LIB_MARIADB_CONNECTOR_NAME}"    "${LIB_MARIADB_CONNECTOR_URL}"    \
  && wget -q -O "${TOMCAT_LIB}/${LIB_GERONIMO_COMMONJ_NAME}"     "${LIB_GERONIMO_COMMONJ_URL}"     \
  && wget -q -O "${TOMCAT_LIB}/${LIB_MYFOO_COMMONJ_NAME}"        "${LIB_MYFOO_COMMONJ_URL}"        \
  && wget -q -O "${TOMCAT_LIB}/${LIB_POSTGRESQL_CONNECTOR_NAME}" "${LIB_POSTGRESQL_CONNECTOR_URL}" \
  && wget -q -O "${TOMCAT_LIB}/${LIB_HSQLDB_JDBC_DRIVER_NAME}"   "${LIB_HSQLDB_JDBC_DRIVER_URL}"

FROM openjdk:8

# Knowage home directory
ENV KNOWAGE_DIRECTORY /home/knowage

# Tomcat sub-directories
ARG TOMCAT_HOME=${KNOWAGE_DIRECTORY}/apache-tomcat
ARG TOMCAT_BIN=${TOMCAT_HOME}/bin
ARG TOMCAT_CONF=${TOMCAT_HOME}/conf
ARG TOMCAT_LIB=${TOMCAT_HOME}/lib
ARG TOMCAT_WEBAPPS=${TOMCAT_HOME}/webapps
ARG TOMCAT_RESOURCES=${TOMCAT_HOME}/resources

WORKDIR ${KNOWAGE_DIRECTORY}

# Copy common files
COPY CHANGELOG.md LICENSE  README.md entrypoint.sh wait-for-it.sh ./

# Install required packages and clean up to save space
RUN  apt-get update \
  && apt-get install -q --no-install-recommends -y wget coreutils unzip mariadb-client-10.3 xmlstarlet \
  && rm -rf /var/lib/apt/lists/*

COPY --from=init ${KNOWAGE_DIRECTORY}/mysql/ ${KNOWAGE_DIRECTORY}/mysql/

ENV MYSQL_SCRIPT_DIRECTORY ${KNOWAGE_DIRECTORY}/mysql

COPY --from=init ${TOMCAT_HOME} ${TOMCAT_HOME}

#make the script executable by bash (not only sh) and
#make knowage running forever without exiting when running the container
RUN  sed -i "s/bin\/sh/bin\/bash/"                   ${TOMCAT_BIN}/startup.sh \
  && sed -i "s/EXECUTABLE\" start/EXECUTABLE\" run/" ${TOMCAT_BIN}/startup.sh

# Fix permissions
RUN chmod +x ${TOMCAT_BIN}/*

# Expose common tomcat port
EXPOSE 8080 8009

HEALTHCHECK --start-period=120s                                          \
            --interval=10s                                               \
            --timeout=5s                                                 \
            --retries=5                                                  \
            CMD wget -q --spider http://127.0.0.1:8080/knowage || exit 1

ENTRYPOINT ["./entrypoint.sh"]

VOLUME ["${TOMCAT_RESOURCES}"]

CMD ["./apache-tomcat/bin/startup.sh"]
