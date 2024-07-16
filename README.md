2. Maven Project with Docker and Jenkins

Creating Maven Project:




Creating new dockerfile in the same maven project directory:



Uploading maven project to Github using Git:



Setting up a Jenkins Pipeline:


Pipeline Script:

pipeline {
    agent any
    tools {
        maven 'Maven 3.8.4' // Ensure this matches the name given in Global Tool Configuration
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/RV0225/jenkins_maven.git'
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("my-app:latest")
                }
            }
        }
        stage('Run Tests') {
            steps {
                script {
                    dockerImage.inside {
                        bat 'mvn test'
                    }
                }
            }
        }
    }
    post {
        always {
            junit '**/target/surefire-reports/*.xml'
        }
        success {
            echo 'Build, Test, and Docker Image Build successful!'
        }
        failure {
            echo 'Build, Test, or Docker Image Build failed.'
        }
    }
}

Pulling the Source Code:





