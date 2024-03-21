pipeline {
    agent any

    environment {
        def trailrunnerDir = "trailrunner/"
        def seleniumResultsDir = "Selenium/infotivCarRental/test_results"
    }

    stages {
        stage('Build') {
            steps {
                bat "mvn -f ${trailrunnerDir} clean"
                bat "mvn -f ${trailrunnerDir} compile"
            }
        }

        stage('Test') {
            steps {
                bat "mvn -f ${trailrunnerDir} test"
            }
        }

        stage('Post Test') {
            steps {
                junit '**/TEST*.xml'

                jacoco(
                    execPattern: "${trailrunnerDir}target/*.exec",
                    classPattern: "${trailrunnerDir}target/classes",
                    sourcePattern: "${trailrunnerDir}src/main/java",
                    exclusionPattern: "${trailrunnerDir}src/test*"
                )                
            }
        }

        stage('Run Robot and Post Test') {
            steps {
                bat "robot --nostatusrc --outputdir ${seleniumResultsDir} Selenium/infotivCarRental/tests/carRental.robot"
            }

            post {
                always {
                    step([
                        $class              : 'RobotPublisher',
                        outputPath          : "${seleniumResultsDir}",
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