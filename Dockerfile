# Use the official JDK 17 image as a parent image
FROM openjdk:17-jdk-alpine

ARG APP_VERSION

# Set the working directory in the container
WORKDIR /app

# Copy the packaged Spring Boot jar file into the container
COPY build/libs/02-jenkins-docker-${APP_VERSION}.jar my-first-app.jar

# Expose the port the application runs on
EXPOSE 8080

# Set the command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "my-first-app.jar"]
