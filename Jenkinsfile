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
           script {
           timeout(time: 2, unit: 'MINUTES') {
               def qg = waitForQualityGate()
               if (qg.status != 'OK') {
                   error "Pipeline failed due to SonarQube quality gate!"
               }
           }
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
       stage('Send slack notification') {
        post {
         success {
             slackSend (
                channel: '@U08AU78NX2B', 
                color: 'good', 
                message: "Build Successful: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
            )
        }
         failure {
               slackSend (
                channel: '@U08AU78NX2B', 
                color: 'danger', 
                message: "Build Failed: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})"
            )
        }
         always {
                echo 'This will always run after the stages, regardless of success or failure.'
        }
    }
}
}
