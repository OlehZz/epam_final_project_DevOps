FROM openjdk:8-jre-alpine
COPY footgo/target/ROOT.war /
EXPOSE 8080
ENTRYPOINT java -jar ROOT.war
