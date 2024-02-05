FROM registry.access.redhat.com/ubi8/openjdk-11

COPY target/tekton-spring-boot-0.0.1-SNAPSHOT.jar .

ENTRYPOINT ["java","-jar","tekton-spring-boot-0.0.1-SNAPSHOT.jar"]
