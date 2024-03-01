pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                dir('trailrunner') {
                    sh 'mvn compile'
                }
            }
        }
    }
}