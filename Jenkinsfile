pipeline {
    agent any
    options {
        timeout(time: 1, unit: 'HOURS') // Timeout the entire pipeline after 1 hour
        retry(2) // Retry failed stages up to 3 times
        buildDiscarder(logRotator(numToKeepStr: '10')) // Keep the last 10 builds
        skipDefaultCheckout() // Skip the default checkout

    }
    tools {
            jdk 'JAVA_HOME' // Use JDK 11 installed on the agent
            gradle 'GRADLE_HOME' // Use Gradle 6.5 installed on the agent
    }
    environment {
        SDP_FILE = 'sdp.yaml'
        DOCKER_CREDENTIALS_ID = ''
        DOCKER_IMAGE = ''
        DOCKER_REGISTRY = ''
    }
    stages {
        stage('Initialize') {
                steps {
                    script {
                         def sdpConfig = readYaml(file: "${SDP_FILE}")
                         env.DOCKER_CREDENTIALS_ID = sdpConfig.dockerCredentialsId
                         env.DOCKER_IMAGE = sdpConfig.dockerImage
                         env.DOCKER_REGISTRY = sdpConfig.dockerRegistry
                         checkout scm
                         echo 'Initializing pipeline...'
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
