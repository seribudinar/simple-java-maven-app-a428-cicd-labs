#Define your base image
FROM eclipse-temurin:17-jdk-focal

#Maintainer of this image
LABEL maintainer="Khalifah"

#Copying Jar file from target folder  
COPY target/_.jar _.jar

#Expose app to outer world on this port  
EXPOSE 8081

#Run executable with this command  
ENTRYPOINT ["java", "-jar", "*.jar"]
