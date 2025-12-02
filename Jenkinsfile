pipeline {
    agent any

    environment {
        REGISTRY_URL = 'harbor.registry.local'
        IMAGE_NAME = 'skr-backend'
        FRONTEND_IMAGE_NAME = 'skr-frontend'
        IMAGE_TAG = "v${BUILD_NUMBER}"
        DOCKER_BUILDKIT = '1'
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: "https://github.com/ranjansanjit/SKR_BdayBot_Pro.git"
            }
        }

        stage('Build Backend Image') {
            steps {
                dir('backend') { 
                    timeout(time: 15, unit: 'MINUTES') { // Timeout to prevent agent disconnect
                        sh """
                            docker build -t ${REGISTRY_URL}/skr/${IMAGE_NAME}:latest .
                            docker tag ${REGISTRY_URL}/skr/${IMAGE_NAME}:latest ${REGISTRY_URL}/skr/${IMAGE_NAME}:${IMAGE_TAG}
                        """
                    }
                }
            }
        }

        stage('Build Frontend Image') {
            steps {
                dir('frontend') { 
                    timeout(time: 20, unit: 'MINUTES') { // Timeout increased for frontend builds
                        sh """
                            docker build -t ${REGISTRY_URL}/skr/${FRONTEND_IMAGE_NAME}:latest .
                            docker tag ${REGISTRY_URL}/skr/${FRONTEND_IMAGE_NAME}:latest ${REGISTRY_URL}/skr/${FRONTEND_IMAGE_NAME}:${IMAGE_TAG}
                        """
                    }
                }
            }
        }

        stage('Push Docker Images') {
            steps {
                sh "docker push ${REGISTRY_URL}/skr/${IMAGE_NAME}:latest"
                sh "docker push ${REGISTRY_URL}/skr/${IMAGE_NAME}:${IMAGE_TAG}"
                sh "docker push ${REGISTRY_URL}/skr/${FRONTEND_IMAGE_NAME}:latest"
                sh "docker push ${REGISTRY_URL}/skr/${FRONTEND_IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
    }

    post {
        success {
            echo "Build SUCCESS for SKR_BdayBot_Pro #${env.BUILD_NUMBER}"
        }
        failure {
            echo "Build FAILED for SKR_BdayBot_Pro #${env.BUILD_NUMBER}"
        }
    }
}
