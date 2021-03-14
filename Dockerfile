FROM openjdk:8-jre-alpine
COPY --from=builder footgo/target/ROOT.war /
EXPOSE 8080
ENTRYPOINT java -jar ROOT.war
