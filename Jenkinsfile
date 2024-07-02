pipeline {
    agent any
    options {
        timeout(time: 1, unit: 'HOURS') // Timeout the entire pipeline after 1 hour
        retry(2) // Retry failed stages up to 3 times
        buildDiscarder(logRotator(numToKeepStr: '10')) // Keep the last 10 builds
        skipDefaultCheckout() // Skip the default checkout

    }
     tools {
            jdk 'JDK 11' // Use JDK 11 installed on the agent
            gradle 'Gradle 6.5' // Use Gradle 6.5 installed on the agent
        }

    stages {
        stage('Build') {
                    steps {
                        script {
                            // Build the project using Gradle
                            sh './gradlew clean build'
                        }
                    }
        }
    }
}
