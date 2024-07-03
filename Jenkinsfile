def IMAGE_NAME

pipeline {
    agent any
    options {
        timeout(time: 1, unit: 'HOURS') // Timeout the entire pipeline after 1 hour
        retry(1) // Retry failed stages up to 3 times
        buildDiscarder(logRotator(numToKeepStr: '10')) // Keep the last 10 builds
        skipDefaultCheckout() // Skip the default checkout
        timestamps()//add timestamp in the log
        disableConcurrentBuilds()// at a time, only one build should run

    }
    tools {
            jdk 'JAVA_HOME' // Use JDK 11 installed on the agent
            gradle 'GRADLE_HOME' // Use Gradle 6.5 installed on the agent
    }
    environment {
        CONFIG_FILE = 'sdp.yml'
    }
    stages {
        stage('Initialize') {
                steps {
                    script {
                         checkout scm
                         // Read the properties file
                         def config = readProperties file: "${CONFIG_FILE}"
                         env.DOCKER_CREDENTIALS_ID = config.dockerCredentialsId
                         env.SERVICE_NAME = config.serviceName
                         env.APP_VERSION = config.appVersion
                         env.DOCKER_REGISTRY = config.dockerRegistry
                         //logging values
                         env.IMAGE_NAME = "${env.SERVICE_NAME}:${env.APP_VERSION}"
                         echo "Docker Credentials ID: ${env.DOCKER_CREDENTIALS_ID}"
                         echo "Docker Image: ${env.SERVICE_NAME}"
                         echo "Docker Registry: ${env.IMAGE_NAME}"

                    }
                }
        }
        stage('Build') {
                    steps {
                        script {
                            // Build the project using Gradle
                            bat 'gradle clean build'
                        }
                    }
        }
         stage('Build Docker Image') {
                    steps {
                        script {
                            // Build the Docker image
                            docker.build("${env.IMAGE_NAME}:${env.BUILD_ID}")
                        }
                    }
                }
    }
}
