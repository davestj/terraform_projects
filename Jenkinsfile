pipeline {
    agent any

    options {
        skipDefaultCheckout()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm: [
                    $class: 'GitSCM',
                    userRemoteConfigs: [[url: 'git@github.com:davestj/terraform_projects.git']],
                    branches: [[name: '*/devel']]
                ]
            }
        }

        stage('Build') {
            steps {
                script {
                    echo "Hello ${JOB_NAME} CI builder"
                    sh 'ls -lstat'
                    sh 'cd wordpress-aws-demo && terraform init'
                    sh 'cd wordpress-aws-demo && tflint --loglevel=debug --module'
                }
            }
        }
    }
}

