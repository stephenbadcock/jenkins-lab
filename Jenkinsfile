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
                dir('Selenium/infotivCarRental') {
                    bat script: 'robot --nostatusrc tests/carRental.robot', returnStatus: true
                }
            }

            post {
                always {
                    step([
                        $class              : 'RobotPublisher',
                        outputPath          : 'Selenium/infotivCarRental',
                        outputFileName      : "output.xml",
                        reportFileName      : 'report.html',
                        logFileName         : 'log.html',
                        disableArchiveOutput: false,
                        passThreshold       : 100.0,
                        unstableThreshold   : 95.0,
                        otherFiles          : "**/*.png",                       
                    ])
                }
            }
        }
    }
}