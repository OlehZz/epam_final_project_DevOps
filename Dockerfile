FROM openjdk:8-jre-alpine
COPY --from=builder /home/ubuntu/jenkins/workspace/setup jenkins node/footgo/target/ROOT.war /
EXPOSE 8080
ENTRYPOINT java -jar ROOT.war
