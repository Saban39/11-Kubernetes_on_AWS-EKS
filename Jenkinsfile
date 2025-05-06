#!/usr/bin/env groovy

pipeline {
    agent any
    tools {
        gradle 'Gradle'
    }
    environment {
        ECR_REPO_URL = '524196012679.dkr.ecr.eu-central-1.amazonaws.com/sg1905'
        IMAGE_REPO = "${ECR_REPO_URL}/java-app"
        IMAGE_NAME = "1.0-${BUILD_NUMBER}"
        CLUSTER_NAME = "my-cluster"
        CLUSTER_REGION = "eu-central-1"
        
        AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key_id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins_aws_secret_access_key')
        PATH = "/Users/sgworker/.docker/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        DOCKER_HOST = "unix:///Users/sgworker/.docker/run/docker.sock"
    }
    stages {
        stage('build app') {
            steps {
               script {
                   echo "building the application..."
                   sh 'gradle clean build'
               }
            }
        }
        
        stage('Get ECR Login Password') {
            steps {
                script {
                    try {
                        // Print environment variables for debugging purposes
                        echo "ECR Region: $CLUSTER_REGION"
                        echo "ECR Repo URL: $ECR_REPO_URL"

                        // Run the AWS CLI command to get the login password
                        def password = sh(script: "aws ecr get-login-password --region $CLUSTER_REGION", returnStdout: true).trim()

                        // Store the password in the environment variable
                        env.ECR_PASSWORD = password

                        // Print the obtained password (avoid printing the actual password in production)
                        echo "Successfully retrieved the ECR login password (printing only the length for debugging purposes): ${password.length()}"

                    } catch (Exception e) {
                        // Catch any errors and print them to help with debugging
                        echo "Error during ECR password retrieval: ${e.getMessage()}"
                        currentBuild.result = 'FAILURE'
                        throw e
                    }
                }
            }
        }

        stage('Docker Login to ECR') {
            steps {
                script {
                    // Login to Docker using the password
                    sh "echo $ECR_PASSWORD | docker login --username AWS --password-stdin $ECR_REPO_URL"
                }
            }
        }
        stage('build image') {
            steps {
                script {
                    echo "building the docker image..."
                    sh "docker build -t ${IMAGE_REPO}:${IMAGE_NAME} ."
                   

                    sh "docker push ${IMAGE_REPO}:${IMAGE_NAME}"
                }
            }
        }
        stage('deploy') {
            environment {
                APP_NAME = 'java-app'
                APP_NAMESPACE = 'my-app'
                DB_USER_SECRET = credentials('db_user')
                DB_PASS_SECRET = credentials('db_pass')
                DB_NAME_SECRET = credentials('db_name')
                DB_ROOT_PASS_SECRET = credentials('db_root_pass')
            }
            steps {
                script {
                    sh "aws eks update-kubeconfig --name ${CLUSTER_NAME} --region ${CLUSTER_REGION}"

                    env.DB_USER = sh(script: 'echo -n $DB_USER_SECRET | base64', returnStdout: true).trim()
                    env.DB_PASS = sh(script: 'echo -n $DB_PASS_SECRET | base64', returnStdout: true).trim()
                    env.DB_NAME = sh(script: 'echo -n $DB_NAME_SECRET | base64', returnStdout: true).trim()
                    env.DB_ROOT_PASS = sh(script: 'echo -n $DB_ROOT_PASS_SECRET | base64', returnStdout: true).trim()
                    
                    echo 'deploying new release to EKS...'
                    sh 'envsubst < k8s-deployment/java-app-cicd.yaml | kubectl apply -f -'
                    sh 'envsubst < k8s-deployment/db-config-cicd.yaml | kubectl apply -f -'
                    sh 'envsubst < k8s-deployment/db-secret-cicd.yaml | kubectl apply -f -'
                }
            }
        }
    }
}
