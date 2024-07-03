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
                         env.DOCKER_IMAGE = config.dockerImage
                         env.DOCKER_REGISTRY = config.dockerRegistry

                         echo "Docker Credentials ID: ${env.DOCKER_CREDENTIALS_ID}"
                         echo "Docker Image: ${env.DOCKER_IMAGE}"
                         echo "Docker Registry: ${env.DOCKER_REGISTRY}"
                         }

                         IMAGE_NAME = env.SERVICE_NAME
                         echo "Initializing pipeline... with image name ${IMAGE_NAME}"
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
    }
}
