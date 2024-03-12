pipeline {
    agent any

    parameters {
        choice(description: 'Choose branch in the Github repository https://github.com/stephenbadcock/jenkins-lab', name: 'githubBranch', choices: 'main\nb1')
    }

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
                dir('Selenium/infotivCarRental') {
                    bat 'robot --nostatusrc --outputdir test_results tests/carRental.robot'
                }
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