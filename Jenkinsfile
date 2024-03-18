pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                bat 'mvn -f trailrunner/ clean'
                bat 'mvn -f trailrunner/ compile'
            }
        }

        stage('Test') {
            steps {
                bat 'mvn -f trailrunner/ test'
            }
        }

        stage('Post Test') {
            steps {
                junit '**/TEST*.xml'

                jacoco(
                    execPattern: 'trailrunner/target/*.exec',
                    classPattern: 'trailrunner/target/classes',
                    sourcePattern: 'trailrunner/src/main/java',
                    exclusionPattern: 'trailrunner/src/test*'
                )                
            }
        }

        stage('Run Robot and Post Test') {
            steps {
                bat 'robot --nostatusrc --outputdir Selenium/infotivCarRental/test_results Selenium/infotivCarRental/tests/carRental.robot'
            }

            post {
                always {
                    step([
                        $class              : 'RobotPublisher',
                        outputPath          : 'Selenium/infotivCarRental/test_results',
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