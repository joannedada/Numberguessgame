pipeline {
    agent any

    environment {
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
                sh 'mvn clean package'
            }
        }

        stage('Run Unit Tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh """
                        mvn sonar:sonar \
                        -Dsonar.projectKey=your_project_key \
                        -Dsonar.host.url=${SONARQUBE_URL}
                    """
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

    post {
        success {
            script {
                def slackWebhook = credentials('slack-webhook-url')
                sh """
                curl -X POST -H 'Content-type: application/json' \
                --data '{"text": "Build Successful: Job ${env.JOB_NAME} [${env.BUILD_NUMBER}] (${env.BUILD_URL})"}' \
                ${slackWebhook}
                """
            }
        }
        failure {
            script {
                def slackWebhook = credentials('slack-webhook-url')
                sh """
                curl -X POST -H 'Content-type: application/json' \
                --data '{"text": "Build Failed: Job ${env.JOB_NAME} [${env.BUILD_NUMBER}] (${env.BUILD_URL})"}' \
                ${slackWebhook}
                """
            }
        }
        always {
            echo 'This will always run after the stages, regardless of success or failure.'
        }
    }
}
