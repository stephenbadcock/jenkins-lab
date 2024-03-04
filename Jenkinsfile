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
                always {
                    dir('trailrunner') {
                        junit '**/TEST*.xml'
                    }
                }
            }
        }
    }
}