#!/bin/bash

JVM_17=/usr/lib/jvm/temurin-17-jdk-amd64/bin/java
JVM_8=/usr/lib/jvm/temurin-8-jdk-amd64/bin/java

if [[ $JAVA_VERSION = 17 ]]; then
  $JVM_17 -Xmx$JAVA_MEMORY_ALLOCATION -Xms$JAVA_MEMORY_ALLOCATION -jar server.jar nogui
fi

if [[ $JAVA_VERSION = 8 ]]; then
  $JVM_8 -Xmx$JAVA_MEMORY_ALLOCATION -Xms$JAVA_MEMORY_ALLOCATION -jar server.jar nogui
fi

touch /tmp/SERVER_EXITED
