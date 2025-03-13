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
                    deploy adapters: [tomcat9(credentialsId: '837862a1-a5b8-4c43-bd06-ee93f4f282dc', path: '', url: 'http://54.242.25.76:8080/')], 
                            contextPath: 'Numberguessgame', war: '**/*.war'
                }
            }
        }
    }
}
