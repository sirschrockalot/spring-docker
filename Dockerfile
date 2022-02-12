# Maven 
FROM maven:3.8.1-openjdk-11-slim AS build
WORKDIR /app
COPY pom.xml .
RUN mvn -e -B dependency:resolve
COPY src ./src
RUN mvn clean -e -B package                                

FROM openjdk:11-jre-slim-buster                              
COPY --from=build /app/target/spring-docker-0.0.1-SNAPSHOT.jar .         
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "spring-docker-0.0.1-SNAPSHOT.jar"]  
