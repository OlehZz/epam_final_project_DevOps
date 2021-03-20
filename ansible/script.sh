#!/bin/bash
cp /home/ubuntu/jenkins/workspace/'deploy footgo app'/footgo/src/main/resources/application.properties.example /home/ubuntu/jenkins/workspace/'deploy footgo app'/footgo/src/main/resources/application.properties
#export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
export MAVEN_OPTS="-Xmx1024m"
sed -i 's/spring.datasource.username=root/spring.datasource.username=footgo/g' /home/ubuntu/jenkins/workspace/'deploy footgo app'/footgo/src/main/resources/application.properties
sed -i 's/spring.datasource.url=jdbc:mysql:\/\/localhost/spring.datasource.url=jdbc:mysql:\/\/terraform-20210310112809528000000001.cnowmm0u4gtt.us-east-1.rds.amazonaws.com/g' /home/ubuntu/jenkins/workspace/'deploy footgo app'/footgo/src/main/resources/application.properties