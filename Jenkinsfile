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

        stage('Notify Team') {
            steps {
                mail to: 'orezikoko@gmail.com',
                     subject: "Deployment Successful",
                     body: "The application has been successfully deployed!"
            }
        }
    }
}
