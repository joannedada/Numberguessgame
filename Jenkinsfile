pipeline {
    agent any

    environment {
        MVN_HOME = '/usr/bin/mvn'  // Adjust if necessary
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/joannedada/Numberguessgame.git'
            }
        }

        stage('Build Application') {
            steps {
                sh "${MVN_HOME} clean package"
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh "${MVN_HOME} test"
            }
        }
        stage('Deploy to Tomcat') {
            steps {
                script {
                    deploy adapters: [tomcat9(credentialsId: '671af030-f025-4134-a298-376ff732397d', path: '', url: 'http://20.234.196.160:8080/')], 
                            contextPath: 'Numberguessgame', war: '**/*.war'
                }
            }
        }
    }
}
