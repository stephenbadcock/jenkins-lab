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
            post {
                always {
                    junit '**/TEST*.xml'
                }
            }
        }

        stage('Post Test') {
            steps {
                dir('trailrunner') {
                    always {
                        junit '**/TEST*.xml'
                    }
                }
            }
        }
    }
}