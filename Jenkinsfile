pipeline {
  
    agent any

    environment {
        IMAGE_TAG = "v${BUILD_NUMBER}"
    }

    options {
        skipDefaultCheckout()
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/ranjansanjit/SKR_BdayBot_Pro.git'
            }
        }


    post {
        success {
            emailext(
                to: 'sanjit.ranjan@dishhome.com.np',
                subject: "Build SUCCESS: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: "The build completed successfully.\nSee details at ${env.BUILD_URL}console"
            )
        }
        failure {
            emailext(
                to: 'sanjit.ranjan@dishhome.com.np',
                subject: "Build FAILED: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: "The build failed.\nCheck logs at ${env.BUILD_URL}console"
            )
        }
    }
}
