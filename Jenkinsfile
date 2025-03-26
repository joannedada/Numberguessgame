
pipeline {
    agent any
  
    triggers {
        githubPush() // 🔹 Triggers a build when code is pushed to GitHub

    }  

    environment {
        SONARQUBE_URL = 'http://18.225.54.36:9000'
        DOCKER_IMAGE = "18.220.40.165:8082/repository/docker-hosted/numberguessgame"
        IMAGE_TAG = "latest-${env.BUILD_NUMBER}"
        NEXUS_URL = "http://18.220.40.165:8082"
        NEXUS_REPO = "docker-hosted"
        TRIVY_REPORT = "trivy-report.txt"
    }

    stages {
        stage('Checkout Code') {
            steps {
                
                git branch: 'joannedada-patch-2',credentialsId: '94314cb6-e9e6-4ea5-807b-fd3e3489a583', url: 'https://github.com/Elijahleke/NumberGuessGame.git'
            }
        }

        stage('Build Java Application') {
            steps {
                sh 'mvn clean package'
                archiveArtifacts artifacts: '**/target/*.war', fingerprint: true
            }
        }

        stage('Run Unit Tests') {  //  NEW: Added a stage to run JUnit tests
            steps {
                sh 'mvn test'  // Runs JUnit tests
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'  //  NEW: Publish JUnit test reports
                }
            }
        }

        stage('Run SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh """
                        mvn sonar:sonar \
                        -Dsonar.projectKey=NumberGuessGame \
                        -Dsonar.host.url=${SONARQUBE_URL}
                    """
                }
            }
        }

        stage('List Files') {
            steps {
                sh 'ls -l'  // Debug step to check if Dockerfile exists
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Scan Image with Trivy') {
            steps {
                script {
                    sh """
                    docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
                    aquasec/trivy image --exit-code 1 --no-progress ${DOCKER_IMAGE}:${IMAGE_TAG} | tee ${TRIVY_REPORT}
                    """
                }
            }
        }

        stage('Push Docker Image to Nexus') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'nexusid', usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASS')]) {
                        sh '''
                        echo "🔹 Logging into Nexus Docker registry..."
                        echo "${NEXUS_PASS}" | docker login -u "${NEXUS_USER}" --password-stdin "${NEXUS_URL}"
        
                        # Remove http:// or https:// from NEXUS_URL before tagging
                        NEXUS_HOST=$(echo ${NEXUS_URL} | sed 's|http://||' | sed 's|https://||')
        
                        echo "🔹 Tagging and pushing image..."
                        docker tag ${DOCKER_IMAGE}:${IMAGE_TAG} ${NEXUS_HOST}/repository/${NEXUS_REPO}/numberguessgame:${IMAGE_TAG}
                        docker push ${NEXUS_HOST}/repository/${NEXUS_REPO}/numberguessgame:${IMAGE_TAG}
                        '''
                    }
                }
            }
        }

        stage('Deploy WAR to Tomcat') {
            steps {
                script {
                    deploy adapters: [tomcat9(credentialsId: 'tomcatid', path: '', url: 'http://18.220.40.165:8080/')], 
                            contextPath: 'Numberguessgame', war: '**/*.war'
                }
            }
        }
    }

    post {
        success {
            emailext subject: "✅ Jenkins Build Success: ${env.JOB_NAME}",
                     body: "Build #${env.BUILD_NUMBER} was successful.\nCheck details: ${env.BUILD_URL}",
                     to: "orezikoko@gmail.com,adeleked@gmail.com,yolecollins5@gmail.com,FemiMykael@gmail.com,gigloria7@gmail.com"
        }
        failure {
            emailext subject: "❌ Jenkins Build Failed: ${env.JOB_NAME}",
                     body: "🚨 Build #${env.BUILD_NUMBER} failed! Logs: ${env.BUILD_URL}",
                     to: "orezikoko@gmail.com,adeleked@gmail.com,yolecollins5@gmail.com,FemiMykael@gmail.com,gigloria7@gmail.com"
        }
        
        always {
            script {
                echo "🔍 DEBUG: Sending email..."
            }
            emailext subject: "Jenkins Build Completed: ${env.JOB_NAME}",
                     body: "Build #${env.BUILD_NUMBER} finished. Status: ${currentBuild.result}\n🔗 Logs: ${env.BUILD_URL}",
                     to: "orezikoko@gmail.com,adeleked@gmail.com,yolecollins5@gmail.com,FemiMykael@gmail.com,gigloria7@gmail.com"
        }
    }
}
