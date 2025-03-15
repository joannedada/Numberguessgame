pipeline {
    agent any

    environment {
        SONARQUBE_URL = 'http://54.160.192.105:9000'
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
                    deploy adapters: [tomcat9(credentialsId: '837862a1-a5b8-4c43-bd06-ee93f4f282dc', path: '', url: 'http://54.242.25.76:8080/')], 
                            contextPath: 'Numberguessgame', war: '**/*.war'
                }
            }
        }
    }

    post {
        success {
            emailext subject: "Jenkins Build Success: ${env.JOB_NAME}",
                     body: "Build #${env.BUILD_NUMBER} was successful.\nCheck the details at: ${env.BUILD_URL}",
                     to: "orezikoko@gmail.com"
        }
        failure {
            emailext subject: "❌ Jenkins Build Failed: ${env.JOB_NAME}",
                     body: """
                        🚨 Build #${env.BUILD_NUMBER} has failed!
                        🔍 Job: ${env.JOB_NAME}
                        🔗 Check logs: ${env.BUILD_URL}
                        Please investigate ASAP.
                     """,
                     to: "orezikoko@gmail.com"
        }
        always {
            emailext subject: "Jenkins Build Completed: ${env.JOB_NAME}",
                     body: """
                        Build #${env.BUILD_NUMBER} has finished.
                        Status: ${currentBuild.result}
                        🔗 Logs: ${env.BUILD_URL}
                     """,
                     to: "orezikoko@gmail.com"
        }
    }
}
