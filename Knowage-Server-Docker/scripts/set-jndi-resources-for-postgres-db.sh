#!/bin/bash
set -e

DB_HOST=$1
DB_PORT=$2
DB_DB=$3
DB_USER=$4
DB_PASS=$5
DB_CONNECTION_POOL_SIZE=$6
DB_CONNECTION_MAX_IDLE=$7
DB_CONNECTION_WAIT_MS=$8

xmlstarlet ed -P -L \
        -u "//Server/GlobalNamingResources/Resource[@name='jdbc/knowage']/@url"             -v "jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_DB}" \
        -u "//Server/GlobalNamingResources/Resource[@name='jdbc/knowage']/@driverClassName" -v "org.postgresql.Driver" \
        -u "//Server/GlobalNamingResources/Resource[@name='jdbc/knowage']/@username"        -v "${DB_USER}" \
        -u "//Server/GlobalNamingResources/Resource[@name='jdbc/knowage']/@password"        -v "${DB_PASS}" \
        -u "//Server/GlobalNamingResources/Resource[@name='jdbc/knowage']/@maxTotal"        -v "${DB_CONNECTION_POOL_SIZE}" \
        -u "//Server/GlobalNamingResources/Resource[@name='jdbc/knowage']/@maxIdle"         -v "${DB_CONNECTION_MAX_IDLE}" \
        -u "//Server/GlobalNamingResources/Resource[@name='jdbc/knowage']/@maxWaitMillis"   -v "${DB_CONNECTION_WAIT_MS}" \
        ${KNOWAGE_DIRECTORY}/apache-tomcat/conf/server.xml

