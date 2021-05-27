#!/bin/sh

export JAVA_OPTS="${JAVA_OPTS} -Djava.awt.headless=true"

# We add -Duser.timezone=UTC to solve error when establishing connection to Oracle metadata database:
# java.sql.SQLException: ORA-00604: error occurred at recursive SQL level 1
# ORA-01882: timezone region not found
export JAVA_OPTS="${JAVA_OPTS} -Duser.timezone=UTC"

export JAVA_OPTS="$JAVA_OPTS -Dhazelcast.config=$CATALINA_HOME/conf/hazelcast.xml"

export JAVA_OPTS="$JAVA_OPTS -Djava.security.manager -Djava.security.policy=$CATALINA_HOME/conf/knowage-default.policy"

# Specific for Java in containers
export JAVA_OPTS="$JAVA_OPTS -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"
