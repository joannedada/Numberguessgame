pipeline {
    agent any

    environment {
        MVN_HOME = '/usr/bin/mvn'  
        SONARQUBE_URL = 'http://40.113.104.107:9000' 
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
        
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh """
                        mvn sonar:sonar \
                        -Dsonar.projectKey=your_project_key \
                        -Dsonar.host.url=${SONARQUBE_URL} \
                    """
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 30, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
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
