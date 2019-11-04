#!/bin/bash
set -e

if [[ -z "$PUBLIC_ADDRESS" ]]; then
        #get the address of container
        #example : default via 172.17.42.1 dev eth0 172.17.0.0/16 dev eth0 proto kernel scope link src 172.17.0.109
        PUBLIC_ADDRESS=`ip route | grep src | awk '{print $9}'`
fi

#replace the address of container inside server.xml
sed -i "s|http:\/\/.*:8080|http:\/\/${PUBLIC_ADDRESS}:8080|g" ${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}/conf/server.xml
sed -i "s|http:\/\/.*:8080\/knowage|http:\/\/localhost:8080\/knowage|g" ${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}/conf/server.xml
sed -i "s|http:\/\/localhost:8080|http:\/\/${PUBLIC_ADDRESS}:8080|g" ${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}/webapps/knowage/WEB-INF/web.xml

#wait for MySql
./wait-for-it.sh ${DB_HOST}:${DB_PORT} -- echo "MySql is up!"

#insert knowage metadata into db if it doesn't exist
result=`mysql -h${DB_HOST} -P${DB_PORT} -u${DB_USER} -p${DB_PASS} ${DB_DB} -e "SHOW TABLES LIKE '%SBI_%';"`
if [ -z "$result" ]; then
	mysql -h${DB_HOST} -P${DB_PORT} -u${DB_USER} -p${DB_PASS} ${DB_DB} --execute="source ${MYSQL_SCRIPT_DIRECTORY}/MySQL_create.sql"
        mysql -h${DB_HOST} -P${DB_PORT} -u${DB_USER} -p${DB_PASS} ${DB_DB} --execute="source ${MYSQL_SCRIPT_DIRECTORY}/MySQL_create_quartz_schema.sql"
fi

#replace in server.xml
old_connection='url="jdbc:mysql://localhost:3306/knowagedb" username="knowageuser" password="knowagepassword"'
new_connection='url="jdbc:mysql://'${DB_HOST}':'${DB_PORT}'/'${DB_DB}'" username="'${DB_USER}'" password="'${DB_PASS}'"'
sed -i "s|${old_connection}|${new_connection}|" ${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}/conf/server.xml

#generate random HMAC key
hmac_key=$( date +%s | sha256sum | cut -d" " -f 1 )
echo "The HMAC key will be: ${hmac_key}"
sed -i "s|abc123|${hmac_key}|" ${KNOWAGE_DIRECTORY}/${APACHE_TOMCAT_PACKAGE}/conf/server.xml

exec "$@"
