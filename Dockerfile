FROM openjdk:8-jre-alpine
COPY --from=builder /home/ubuntu/jenkins/workspace/setup jenkins node/footgo/target/ROOT.war /
ENTRYPOINT java -jar ROOT.war
