# Use the official JDK 17 image as a parent image
FROM openjdk:17-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the packaged Spring Boot jar file into the container
COPY build/libs/02-jenkins-docker-0.0.1-SNAPSHOT.jar my-first-app.jar

# Expose the port the application runs on
EXPOSE 8080

# Set the command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "my-first-app.jar"]
