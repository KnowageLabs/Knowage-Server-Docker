#!/bin/sh

export CATALINA_OPTS="$CATALINA_OPTS -Djava.awt.headless=true"

# We add -Duser.timezone=UTC to solve error when establishing connection to Oracle metadata database:
# java.sql.SQLException: ORA-00604: error occurred at recursive SQL level 1
# ORA-01882: timezone region not found
export CATALINA_OPTS="$CATALINA_OPTS -Duser.timezone=UTC"

# Global configuration of Hazelcast
export CATALINA_OPTS="$CATALINA_OPTS -Dhazelcast.config=$CATALINA_HOME/conf/hazelcast.xml"

# Java Security Manager
export CATALINA_OPTS="$CATALINA_OPTS -Djava.security.manager -Djava.security.policy=$CATALINA_HOME/conf/knowage-default.policy"

# Specific for Java in containers
export CATALINA_OPTS="$CATALINA_OPTS -XX:+UnlockExperimentalVMOptions -XX:+UseContainerSupport"

# Enable JMX
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.port=9000"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.rmi.port=9001"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.ssl=false"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.authenticate=false"
export CATALINA_OPTS="$CATALINA_OPTS -Dcom.sun.management.jmxremote.host=0.0.0.0"
export CATALINA_OPTS="$CATALINA_OPTS -Djava.rmi.server.hostname=$( hostname --fqdn )"

# Add libs path where Tomcat can find the libtcnative library for SSL
export CATALINA_OPTS="$CATALINA_OPTS -Djava.library.path=/usr/java/packages/lib/amd64:/usr/lib/x86_64-linux-gnu:/usr/lib64:/lib64:/lib:/usr/lib"

# Set symmetric key for sensible data
export CATALINA_OPTS="$CATALINA_OPTS -Dsymmetric_encryption_key=__symmetric_encryption_key_value__"

# Speed up the boot of Java app which doesn't need a lot of entropy on random values generation
export CATALINA_OPTS="$CATALINA_OPTS -Djava.security.egd=file:/dev/urandom"

# WORKAROUND: Hazelcast 5.3 is not compatible with our version of Xalan/Xerces
export CATALINA_OPTS="$CATALINA_OPTS -Dhazelcast.ignoreXxeProtectionFailures=true"
