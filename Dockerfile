#Define your base image
FROM eclipse-temurin:17-jdk-focal

#Maintainer of this image
LABEL maintainer="Khalifah"

#Copying Jar file from target folder  
COPY target/my-app-1.0-SNAPSHOT.jar my-app-1.0-SNAPSHOT.jar

#Expose app to outer world on this port  
EXPOSE 8081

#Run executable with this command  
ENTRYPOINT ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
