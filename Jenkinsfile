pipeline {
    agent any

    environment {
        REGISTRY_URL = 'harbor.registry.local'
        IMAGE_NAME = 'skr-backend'
        FRONTEND_IMAGE_NAME = 'skr-frontend'
        IMAGE_TAG = "v${BUILD_NUMBER}"
    }

    // Remove skipDefaultCheckout() to avoid workspace issues
    // options { skipDefaultCheckout() }

    stages {

        stage('Checkout Code') {
            steps {
                // This now works because agent already provides node workspace
                git branch: 'main', url: 'https://github.com/ranjansanjit/SKR_BdayBot_Pro.git'
            }
        }

        stage('Build Backend Image') {
            steps {
                dir('app/backend') {
                    sh """
                        docker build -t ${REGISTRY_URL}/skr/${IMAGE_NAME}:latest .
                        docker tag ${REGISTRY_URL}/skr/${IMAGE_NAME}:latest ${REGISTRY_URL}/skr/${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }

        stage('Build Frontend Image') {
            steps {
                dir('app/frontend') {
                    sh """
                        docker build -t ${REGISTRY_URL}/skr/${FRONTEND_IMAGE_NAME}:latest .
                        docker tag ${REGISTRY_URL}/skr/${FRONTEND_IMAGE_NAME}:latest ${REGISTRY_URL}/skr/${FRONTEND_IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
            }
        }

        stage('Login to Harbor') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'HARBOR_CREDENTIALS',
                    usernameVariable: 'HARBOR_USER',
                    passwordVariable: 'HARBOR_PASS'
                )]) {
                    sh "docker login ${REGISTRY_URL} -u $HARBOR_USER -p $HARBOR_PASS"
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

        stage('Deploy to Swarm') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'SWARM_SSH_CREDENTIALS',
                    usernameVariable: 'SSH_USER',
                    passwordVariable: 'SSH_PASS'
                )]) {
                    sh """
                        sshpass -p "$SSH_PASS" ssh -o StrictHostKeyChecking=no $SSH_USER@192.168.56.108 \
                        "docker stack deploy -c /home/vagrant/docker-stack.yml SKR_BdayBot_Pro"
                    """
                }
            }
        }

        stage('Cleanup') {
            steps {
                sh "docker rmi ${REGISTRY_URL}/skr/${IMAGE_NAME}:${IMAGE_TAG} || true"
                sh "docker rmi ${REGISTRY_URL}/skr/${FRONTEND_IMAGE_NAME}:${IMAGE_TAG} || true"
                sh "docker system prune -f"
            }
        }
    }

    post {
        success {
            emailext(
                to: 'sanjit.ranjan@dishhome.com.np',
                subject: "Build SUCCESS: SKR_BdayBot_Pro #${env.BUILD_NUMBER}",
                body: "Build completed successfully.\nDetails: ${env.BUILD_URL}console"
            )
        }
        failure {
            emailext(
                to: 'sanjit.ranjan@dishhome.com.np',
                subject: "Build FAILED: SKR_BdayBot_Pro #${env.BUILD_NUMBER}",
                body: "Build failed.\nCheck logs: ${env.BUILD_URL}console"
            )
        }
    }
}
