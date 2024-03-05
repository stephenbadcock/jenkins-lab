pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                dir('trailrunner') {
                    bat 'mvn compile'
                }
            }
        }

        stage('Test') {
            steps {
                dir('trailrunner') {
                    bat 'mvn test'
                }
            }
        }

        stage('Post Test') {
            steps {
                junit '**/TEST*.xml'
            }
        }

        stage('Run Robot and Post Test') {
            steps {
                dir('Selenium/infotivCarRental/tests') {
                    bat script: 'robot --nostatusrc carRental.robot', returnStatus: true
                }
            }
        }
    }
}