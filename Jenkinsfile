pipeline {
    agent any

    options {
        skipDefaultCheckout()
    }

    stages {
        stage('Copy Parameters') {
            steps {
                script {
                    // Copy parameters from the last successful build of terraform_projects-wp-demo
                    def lastBuild = build(job: 'terraform_projects-wp-demo', status: 'SUCCESS')
                    env.WP_AWS_REGION = lastBuild.buildVariables.WP_AWS_REGION
                    env.ECS_CLUSTER_NAME = lastBuild.buildVariables.ECS_CLUSTER_NAME
                    env.AWS_ACC_ID = lastBuild.buildVariables.AWS_ACC_ID
                    env.INSTANCE_TYPE = lastBuild.buildVariables.INSTANCE_TYPE
                    env.WP_RDS_DB_NAME = lastBuild.buildVariables.WP_RDS_DB_NAME
                    env.WP_RDS_DB_USER = lastBuild.buildVariables.WP_RDS_DB_USER
                    env.WP_RDS_DB_PASS = lastBuild.buildVariables.WP_RDS_DB_PASS
                    env.WP_RDS_DB_STORAGE = lastBuild.buildVariables.WP_RDS_DB_STORAGE
                    env.WP_RDS_DB_IDENTIFIER = lastBuild.buildVariables.WP_RDS_DB_IDENTIFIER
                    env.WP_RDS_DB_SUBNET = lastBuild.buildVariables.WP_RDS_DB_SUBNET
                    env.WP_RDS_DB_SECURITY_GROUP_NAME = lastBuild.buildVariables.WP_RDS_DB_SECURITY_GROUP_NAME
                    env.WP_RDS_DB_ENGINE = lastBuild.buildVariables.WP_RDS_DB_ENGINE
                    copyArtifacts(
                        filter: 'terraform.tfvars',
                        projectName: 'terraform_projects-wp-demo',
                        selector: specific(String.valueOf(lastBuild.number))
                    )
                }
            }
        }

        stage('Checkout') {
            steps {
                checkout scm: [
                    $class: 'GitSCM',
                    userRemoteConfigs: [[url: 'git@github.com:davestj/terraform_projects.git']],
                    branches: [[name: '*/devel']]
                ]
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    dir('wordpress-aws-demo') {
                        sh 'cp -v ../terraform.tfvars . && terraform init'
                    }
                }
            }
        }

        stage('Terraform Lint') {
            steps {
                script {
                    dir('wordpress-aws-demo') {
                        sh 'tflint --loglevel=debug --module'
                    }
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                script {
                    dir('wordpress-aws-demo') {
                        sh 'terraform plan -out=wordpress-aws-demo.plan'
                    }
                }
            }
        }

        stage('Terraform Artifacts') {
            steps {
                script {
                    echo "${JOB_NAME} CI builder artifact list"
                    sh 'ls -lstat'
                }
            }
        }
        
        stage('Saving Terraform Artifacts') {
            steps {
                archiveArtifacts 'wordpress-aws-demo/terraform.tfvars'
                archiveArtifacts 'wordpress-aws-demo/wordpress-aws-demo.plan'
            }
        }

    }
}

