#!/bin/bash
set -e

CACHE_DB_HOST=$1
CACHE_DB_PORT=$2
CACHE_DB_DB=$3
CACHE_DB_USER=$4
CACHE_DB_PASS=$5
CACHE_DB_CONNECTION_POOL_SIZE=$6
CACHE_DB_CONNECTION_MAX_IDLE=$7
CACHE_DB_CONNECTION_WAIT_MS=$8

xmlstarlet ed -P -L \
        -u "//Server/GlobalNamingResources/Resource[@name='jdbc/ds_cache']/@url"             -v "jdbc:oracle:thin:@//${CACHE_DB_HOST}:${CACHE_DB_PORT}/${CACHE_DB_DB}" \
        -u "//Server/GlobalNamingResources/Resource[@name='jdbc/ds_cache']/@driverClassName" -v "oracle.jdbc.OracleDriver" \
        -u "//Server/GlobalNamingResources/Resource[@name='jdbc/ds_cache']/@username"        -v "${CACHE_DB_USER}" \
        -u "//Server/GlobalNamingResources/Resource[@name='jdbc/ds_cache']/@password"        -v "${CACHE_DB_PASS}" \
        -u "//Server/GlobalNamingResources/Resource[@name='jdbc/ds_cache']/@maxTotal"        -v "${CACHE_DB_CONNECTION_POOL_SIZE}" \
        -u "//Server/GlobalNamingResources/Resource[@name='jdbc/ds_cache']/@maxIdle"         -v "${CACHE_DB_CONNECTION_MAX_IDLE}" \
        -u "//Server/GlobalNamingResources/Resource[@name='jdbc/ds_cache']/@maxWaitMillis"   -v "${CACHE_DB_CONNECTION_WAIT_MS}" \
        ${KNOWAGE_DIRECTORY}/apache-tomcat/conf/server.xml

