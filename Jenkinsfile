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
        SDP_FILE = 'sdp.yml'
        DOCKER_CREDENTIALS_ID = ''
        SERVICE_NAME = ''
        SERVICE_VERSION = ''
        DOCKER_REGISTRY = ''
        IMAGE_NAME = ''
    }
    stages {
        stage('Initialize') {
                steps {
                    script {
                         checkout scm
                         def sdpConfig = readYaml(file: "${SDP_FILE}")
                         env.DOCKER_CREDENTIALS_ID = sdpConfig.dockerCredentialsId
                         env.SERVICE_NAME = sdpConfig.serviceName
                         env.SERVICE_VERSION = sdpConfig.appVersion
                         env.DOCKER_REGISTRY = sdpConfig.dockerRegistry
                         env.IMAGE_NAME = ${env.SERVICE_NAME} ${env.SERVICE_VERSION}
                         echo 'Initializing pipeline... with image name'+ env.IMAGE_NAME
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
