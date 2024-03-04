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
            post {
                always {
                    junit '**/TEST*.xml'
                }
            }
        }
    }
}