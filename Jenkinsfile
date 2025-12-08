pipeline {
    agent any

    environment {
        REGISTRY_URL = 'harbor.registry.local'
        IMAGE_NAME = 'skr-backend'
        FRONTEND_IMAGE_NAME = 'skr-frontend'
        IMAGE_TAG = "v${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: "https://github.com/ranjansanjit/SKR_BdayBot_Pro"
            }
        }

        stage('Build Backend Image') {
            steps {

                dir('app/backend') {
                    sh """
                        echo "Building Backend Docker Image..."
                    """
                    // sh """
                    //     docker build -t ${REGISTRY_URL}/skr/${IMAGE_NAME}:latest .
                    //     docker tag ${REGISTRY_URL}/skr/${IMAGE_NAME}:latest ${REGISTRY_URL}/skr/${IMAGE_NAME}:${IMAGE_TAG}
                    // """

                }
            }
        }

        stage('Push Docker Images') {
            steps {

                echo "Pushing Docker Images to ${REGISTRY_URL}..."
                // sh "docker push ${REGISTRY_URL}/skr/${IMAGE_NAME}:latest"
                // sh "docker push ${REGISTRY_URL}/skr/${IMAGE_NAME}:${IMAGE_TAG}"
                // sh "docker push ${REGISTRY_URL}/skr/${FRONTEND_IMAGE_NAME}:latest"
                // sh "docker push ${REGISTRY_URL}/skr/${FRONTEND_IMAGE_NAME}:${IMAGE_TAG}"
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
}
