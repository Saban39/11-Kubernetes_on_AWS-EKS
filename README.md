## Capstone Project 1: Complete CI/CD Pipeline with EKS and AWS ECR

# 11 - Kubernetes on AWS - EKS
#### This project is for the Devops Bootcamp module "Kubernetes on AWS - EKS" 

I created a fully automated CI/CD pipeline to deploy a Java application on an Amazon EKS (Elastic Kubernetes Service) cluster.
Through this project, I learned how to provision an EKS cluster using eksctl,  how to manage Docker images using both Docker Hub and Amazon ECR. 
I also gained hands-on experience in configuring Jenkins pipelines and writing a Jenkinsfile to automate the build, test, and deployment processes.
First, I used eksctl to create an EKS cluster on AWS. Then, I built a Docker image of my Java application and initially tested the deployment using Docker Hub. 
Later, I pushed the image to an Amazon ECR repository. After setting up Jenkins, I wrote a Jenkinsfile to automate the entire CI/CD process — including building the image, pushing it to ECR, and deploying it to the EKS cluster. 
This way, any code changes automatically triggered the pipeline and deployed the updated application.


## 📄 Included PDF Resources

CAPSTONE PROJECT-1

## Evidence / Proof

Here are my notes, work, solutions, and test results for the module **"Kubernetes on AWS - EKS"**:  
👉 [PDF Link to Module Notes & Work](././11-Kubernetes_on_AWS-EKS.pdf)


All of my notes, work, solutions, and test results can be found in the PDF 11-Kubernetes_on_AWS-EKS.pdf. 
My complete documentation, including all notes and tests from the bootcamp, is available in this repository: https://github.com/Saban39/my_devops-bootcamp-pdf-notes-and-solutions.git



## My notes, work, solutions, and test results for Module "Kubernetes on AWS"


<details>
<summary>Solution 1: Create EKS cluster </summary>
 <br>

> EXERCISE 1: Create EKS cluster
You decide to create an EKS cluster - the managed Kubernetes Service of AWS. To simplify the whole creation and configurations, you use eksctl.

- With eksctl you create an EKS cluster with 3 Nodes and 1 Fargate profile

```sh

brew install weaveworks/tap/eksctl
Running `brew update --auto-update`..

aws configure list
      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************VXWD shared-credentials-file    
secret_key     ****************zn2B shared-credentials-file    
    region             eu-central-1      config-file    ~/.aws/config

```

```sh

eksctl create cluster \
--name demo-cluster \
--version 1.17 \
--region eu-west-3 \
--nodegroup-name demo-nodes \
--node-type t2.micro \
--nodes 2 \
--nodes-min 1 \
--nodes-max 3 

!!! Without region the request was failed.
sgworker@MacBook-Pro-3.local /Users/sgworker/Desktop/aws_examples/eks-exercises/k8s-deployment [feature/solutions]
% eksctl create cluster --name=my-test-cluster --nodes=3 --region=eu-central-1 --kubeconfig=./kubeconfig.my-cluster.yaml
2024-01-23 16:53:05 [ℹ]  eksctl version 0.167.0
2024-01-23 16:53:05 [ℹ]  using region eu-central-1
2024-01-23 16:53:05 [ℹ]  setting availability zones to [eu-central-1a eu-central-1b eu-central-1c]
2024-01-23 16:53:05 [ℹ]  subnets for eu-central-1a - public:192.168.0.0/19 private:192.168.96.0/19
2024-01-23 16:53:05 [ℹ]  subnets for eu-central-1b - public:192.168.32.0/19 private:192.168.128.0/19
2024-01-23 16:53:05 [ℹ]  subnets for eu-central-1c - public:192.168.64.0/19 private:192.168.160.0/19
2024-01-23 16:53:05 [ℹ]  nodegroup "ng-19e2f801" will use "" [AmazonLinux2/1.27]
2024-01-23 16:53:05 [ℹ]  using Kubernetes version 1.27
2024-01-23 16:53:05 [ℹ]  creating EKS cluster "my-test-cluster" in "eu-central-1" region with managed nodes
2024-01-23 16:53:05 [ℹ]  will create 2 separate CloudFormation stacks for cluster itself and the initial managed nodegroup
2024-01-23 16:53:05 [ℹ]  if you encounter any issues, check CloudFormation console or try 'eksctl utils describe-stacks --region=eu-central-1 --cluster=my-test-cluster'
2024-01-23 16:53:05 [ℹ]  Kubernetes API endpoint access will use default of {publicAccess=true, privateAccess=false} for cluster "my-test-cluster" in "eu-central-1"
2024-01-23 16:53:05 [ℹ]  CloudWatch logging will not be enabled for cluster "my-test-cluster" in "eu-central-1"
2024-01-23 16:53:05 [ℹ]  you can enable it with 'eksctl utils update-cluster-logging --enable-types={SPECIFY-YOUR-LOG-TYPES-HERE (e.g. all)} --region=eu-central-1 --cluster=my-test-cluster'
2024-01-23 16:53:05 [ℹ]  
2 sequential tasks: { create cluster control plane "my-test-cluster", 
    2 sequential sub-tasks: { 
        wait for control plane to become ready,
        create managed nodegroup "ng-19e2f801",
    } 
}
2024-01-23 16:53:05 [ℹ]  building cluster stack "eksctl-my-test-cluster-cluster"
2024-01-23 16:53:06 [ℹ]  deploying stack "eksctl-my-test-cluster-cluster"
2024-01-23 16:53:36 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-cluster"
2024-01-23 16:54:06 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-cluster"
2024-01-23 16:55:07 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-cluster"
2024-01-23 16:56:07 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-cluster"
2024-01-23 16:57:07 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-cluster"
2024-01-23 16:58:07 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-cluster"
2024-01-23 16:59:07 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-cluster"
2024-01-23 17:00:07 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-cluster"
2024-01-23 17:01:08 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-cluster"
2024-01-23 17:03:09 [ℹ]  building managed nodegroup stack "eksctl-my-test-cluster-nodegroup-ng-19e2f801"
2024-01-23 17:03:10 [ℹ]  deploying stack "eksctl-my-test-cluster-nodegroup-ng-19e2f801"
2024-01-23 17:03:10 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-nodegroup-ng-19e2f801"
2024-01-23 17:03:40 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-nodegroup-ng-19e2f801"
2024-01-23 17:04:30 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-nodegroup-ng-19e2f801"
2024-01-23 17:05:36 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-nodegroup-ng-19e2f801"
2024-01-23 17:06:51 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-nodegroup-ng-19e2f801"
2024-01-23 17:06:51 [ℹ]  waiting for the control plane to become ready
2024-01-23 17:06:53 [✔]  saved kubeconfig as "./kubeconfig.my-cluster.yaml"
2024-01-23 17:06:53 [ℹ]  no tasks
2024-01-23 17:06:53 [✔]  all EKS cluster resources for "my-test-cluster" have been created
2024-01-23 17:06:58 [ℹ]  nodegroup "ng-19e2f801" has 3 node(s)
2024-01-23 17:06:58 [ℹ]  node "ip-192-168-25-127.eu-central-1.compute.internal" is ready
2024-01-23 17:06:58 [ℹ]  node "ip-192-168-36-54.eu-central-1.compute.internal" is ready
2024-01-23 17:06:58 [ℹ]  node "ip-192-168-66-166.eu-central-1.compute.internal" is ready
2024-01-23 17:06:58 [ℹ]  waiting for at least 3 node(s) to become ready in "ng-19e2f801"
2024-01-23 17:06:58 [ℹ]  nodegroup "ng-19e2f801" has 3 node(s)
2024-01-23 17:06:58 [ℹ]  node "ip-192-168-25-127.eu-central-1.compute.internal" is ready
2024-01-23 17:06:58 [ℹ]  node "ip-192-168-36-54.eu-central-1.compute.internal" is ready
2024-01-23 17:06:58 [ℹ]  node "ip-192-168-66-166.eu-central-1.compute.internal" is ready
2024-01-23 17:06:59 [ℹ]  kubectl command should work with "./kubeconfig.my-cluster.yaml", try 'kubectl --kubeconfig=./kubeconfig.my-cluster.yaml get nodes'
2024-01-23 17:06:59 [✔]  EKS cluster "my-test-cluster" in "eu-central-1" region is ready


sgworker@MacBook-Pro-3.local /Users/sgworker/Desktop/aws_examples/eks-exercises/k8s-deployment [feature/solutions]
% eksctl create fargateprofile \
    --cluster my-test-cluster \
    --name my-fargate-profile \
    --namespace my-app

2024-01-23 17:09:27 [ℹ]  deploying stack "eksctl-my-test-cluster-fargate"
2024-01-23 17:09:27 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-fargate"
2024-01-23 17:09:57 [ℹ]  waiting for CloudFormation stack "eksctl-my-test-cluster-fargate"
2024-01-23 17:09:58 [ℹ]  creating Fargate profile "my-fargate-profile" on EKS cluster "my-test-cluster"
2024-01-23 17:12:08 [ℹ]  created Fargate profile "my-fargate-profile" on EKS cluster "my-test-cluster"

sgworker@MacBook-Pro-3.local /Users/sgworker/Desktop/aws_examples/eks-exercises/k8s-deployment [feature/solutions]
% export KUBECONFIG=kubeconfig.my-cluster.yaml


sgworker@MacBook-Pro-3.local /Users/sgworker/Desktop/aws_examples/eks-exercises/k8s-deployment [feature/solutions]
% kubectl get node
NAME                                              STATUS   ROLES    AGE   VERSION
ip-192-168-25-127.eu-central-1.compute.internal   Ready    <none>   14m   v1.27.9-eks-5e0fdde
ip-192-168-36-54.eu-central-1.compute.internal    Ready    <none>   14m   v1.27.9-eks-5e0fdde
ip-192-168-66-166.eu-central-1.compute.internal   Ready    <none>   14m   v1.27.9-eks-5e0fdde

sgworker@MacBook-Pro-3.local /Users/sgworker/Desktop/aws_examples/eks-exercises/k8s-deployment [feature/solutions]
% eksctl get fargateprofile --cluster my-test-cluster
NAME			SELECTOR_NAMESPACE	SELECTOR_LABELS	POD_EXECUTION_ROLE_ARN										SUBNETS										TAGS	STATUS
my-fargate-profile	my-app			<none>		arn:aws:iam::524196012679:role/eksctl-my-test-cluster-farg-FargatePodExecutionRole-6g8yyufsAeLL	subnet-0195a02f726f55406,subnet-0631a7beb86471b81,subnet-0eeb78d80ea08ae07	<none>	ACTIVE




```

</details>




<details>
<summary>Solution 2:  Deploy Mysql and phpmyadmin </summary>
 <br>

> EXERCISE 2: Deploy Mysql and phpmyadmin
You deploy mysql and phpmyadmin on EC2 nodes with the same setup as before.


```sh

sgworker@MacBook-Pro-3.local /Users/sgworker/Desktop/aws_examples/eks-exercises/k8s-deployment [feature/solutions]
% helm repo add bitnami https://charts.bitnami.com/bitnami
"bitnami" already exists with the same configuration, skipping

sgworker@MacBook-Pro-3.local /Users/sgworker/Desktop/aws_examples/eks-exercises/k8s-deployment [feature/solutions]
% helm install my-release bitnami/mysql -f mysql-chart-values-eks.yaml
NAME: my-release
LAST DEPLOYED: Tue Jan 23 17:23:35 2024
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: mysql
CHART VERSION: 9.12.0
APP VERSION: 8.0.34

** Please be patient while the chart is being deployed **

Tip:

  Watch the deployment status using the command: kubectl get pods -w --namespace default

Services:

  echo Primary: my-release-mysql-primary.default.svc.cluster.local:3306
  echo Secondary: my-release-mysql-secondary.default.svc.cluster.local:3306

Execute the following to get the administrator credentials:

  echo Username: root
  MYSQL_ROOT_PASSWORD=$(kubectl get secret --namespace default my-release-mysql -o jsonpath="{.data.mysql-root-password}" | base64 -d)

To connect to your database:

  1. Run a pod that you can use as a client:

      kubectl run my-release-mysql-client --rm --tty -i --restart='Never' --image  docker.io/bitnami/mysql:8.0.34-debian-11-r31 --namespace default --env MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD --command -- bash

  2. To connect to primary service (read/write):

      mysql -h my-release-mysql-primary.default.svc.cluster.local -uroot -p"$MYSQL_ROOT_PASSWORD"

  3. To connect to secondary service (read-only):

      mysql -h my-release-mysql-secondary.default.svc.cluster.local -uroot -p"$MYSQL_ROOT_PASSWORD"

sgworker@MacBook-Pro-3.local /Users/sgworker/Desktop/aws_examples/eks-exercises/k8s-deployment [feature/solutions]
% kubectl apply -f db-config.yaml
configmap/db-config created
sgworker@MacBook-Pro-3.local /Users/sgworker/Desktop/aws_examples/eks-exercises/k8s-deployment [feature/solutions]
% kubectl apply -f db-secret.yaml
secret/db-secret created
sgworker@MacBook-Pro-3.local /Users/sgworker/Desktop/aws_examples/eks-exercises/k8s-deployment [feature/solutions]
% kubectl apply -f phpmyadmin.yaml
deployment.apps/phpmyadmin created
service/phpmyadmin-service created
sgworker@MacBook-Pro-3.local /Users/sgworker/Desktop/aws_examples/eks-exercises/k8s-deployment [feature/solutions]
% kubectl port forward svc/phpmyadmin-service 8081:8081
error: unknown command "port" for "kubectl"

Did you mean this?
	port-forward
sgworker@MacBook-Pro-3.local /Users/sgworker/Desktop/aws_examples/eks-exercises/k8s-deployment [feature/solutions]
% kubectl port-forward svc/phpmyadmin-service 8081:8081
Forwarding from 127.0.0.1:8081 -> 80
Forwarding from [::1]:8081 -> 80
Handling connection for 8081
Handling connection for 8081
Handling connection for 8081
Handling connection for 8081
Handling connection for 8081
Handling connection for 8081





```
<img width="1120" alt="Bildschirmfoto 2024-01-23 um 17 27 23" src="https://github.com/Saban39/DevOps_Bootcamp_Exercises/assets/114495165/0287b931-0332-4be8-a08d-92b8f8746e60">

<img width="1111" alt="Bildschirmfoto 2024-01-23 um 17 26 26" src="https://github.com/Saban39/DevOps_Bootcamp_Exercises/assets/114495165/933955c9-e8d0-4e69-973b-11bc1d23e28e">

<img width="1057" alt="Bildschirmfoto 2024-01-23 um 17 28 13" src="https://github.com/Saban39/DevOps_Bootcamp_Exercises/assets/114495165/d1b893b2-e6b1-44b4-9558-c9f1a32f78a2">

<img width="1122" alt="Bildschirmfoto 2024-01-23 um 17 28 29" src="https://github.com/Saban39/DevOps_Bootcamp_Exercises/assets/114495165/d5495508-b655-4b89-85bc-954737b83e0c">

<img width="994" alt="Bildschirmfoto 2024-01-23 um 17 28 47" src="https://github.com/Saban39/DevOps_Bootcamp_Exercises/assets/114495165/d588eb30-ec36-4a24-a428-d5423f7a9ebe">


</details>




<details>
<summary>Solution 3: Deploy your Java application </summary>
 <br>

> EXERCISE 3: Deploy your Java application
You deploy your Java application using Fargate with 3 replicas and same setup as before

```sh
I have checked the Java app into my GitHub repo: https://github.com/Saban39/demo-app/tree/main/src/main
In the java-app.yaml deployment file, I configured my Docker Hub repository. Then I built the app, created the Docker image, and pushed it to Docker Hub. After that, I deployed it to my EKS cluster using the three Fargate profiles.
```

Step 1: In the first step, I built the application


![Bildschirmfoto 2025-05-09 um 14 22 48](https://github.com/user-attachments/assets/dfd6fda3-7bd7-4514-bab9-9b54771958cb)

Step 2: In the second step, I created the Docker image and pushed it to my own repository.

![Bildschirmfoto 2025-05-06 um 11 31 52](https://github.com/user-attachments/assets/c206b6c2-4b57-4348-9847-93f82cf4fcde)

![Bildschirmfoto 2025-05-06 um 11 31 33](https://github.com/user-attachments/assets/b53251e4-33dd-4a86-820c-a8ca275816ea)

In the third step, I configured the secrets for my Docker repository and updated the deployment in java-app.yaml.

![Bildschirmfoto 2025-05-09 um 14 27 26](https://github.com/user-attachments/assets/516b2dcf-217d-44c3-970f-564e6ea7373b)


```sh
apiVersion: apps/v1
kind: Deployment
metadata:
  name: java-app-deployment
  labels:
    app: java-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: java-app
  template:
    metadata:
      labels:
        app: java-app
    spec:
      imagePullSecrets:
      - name: my-registry-key
      containers:
      - name: javamysqlapp
        image: sg1905/demo-app:java-mysql-app
```

In the fourth step, I executed the following commands to deploy my application with 3 Fargate profiles:

```sh
kubectl apply -f db-secret.yaml -n my-app  
kubectl apply -f db-config.yaml -n my-app  
kubectl apply -f java-app.yaml -n my-app


```



</details>





<details>
<summary>Solution 4-5: Automate deployment </summary>
 <br>

Setup Continuous Deployment with Jenkins and  Use ECR as Docker repository
> EXERCISE 4-5: Automate deployment
Now your application is running. And when you or others make changes to it, Jenkins pipeline builds the new image, but you have to manually deploy it into the cluster. But you know how annoying that is for you and your team from experience, so you want to automate deploying to the cluster as well.

- Setup automatic deploying to the cluster in the pipeline.

Step 1: First, I installed Jenkins locally on my Mac and checked the project into my GitHub repository, which also includes the Jenkinsfile.

![Bildschirmfoto 2025-05-09 um 14 37 59](https://github.com/user-attachments/assets/124a453f-be08-4bae-991e-88b79580d30b)


Step 2: In the second step, I created the Jenkins project demo-aws-eks-java-app and connected it to my Git repository: https://github.com/Saban39/demo-app/

![Bildschirmfoto 2025-05-09 um 14 43 55](https://github.com/user-attachments/assets/7cbfbf10-2348-419d-82bb-7fe8593f81f1)

Step 3: In step 3, I created my ECR repository 524196012679.dkr.ecr.eu-central-1.amazonaws.com/sg1905.

![Bildschirmfoto 2025-05-09 um 18 16 16](https://github.com/user-attachments/assets/4eb10c2d-8e85-4377-b927-5eca582745f8)

Step 4: In step 4, I adjusted my Jenkinsfile for the ECR repository and created the credentials in Jenkins.

Jenkinsfile: 

```sh
#!/usr/bin/env groovy

pipeline {
    agent any
    tools {
        gradle 'Gradle'
    }
    environment {
        ECR_REPO_URL = '524196012679.dkr.ecr.eu-central-1.amazonaws.com/sg1905'
        IMAGE_REPO = "${ECR_REPO_URL}"
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
    // Define a kubeconfig path within the Jenkins workspace
    def kubeconfigPath = "${env.WORKSPACE}/.kube/config"

    // Ensure directory exists
    sh "mkdir -p ${env.WORKSPACE}/.kube"

    // Update kubeconfig with explicit path
    sh "aws eks update-kubeconfig --name ${CLUSTER_NAME} --region ${CLUSTER_REGION} --kubeconfig ${kubeconfigPath}"

    // Export secrets as base64 values
    env.DB_USER = sh(script: 'echo -n $DB_USER_SECRET | base64', returnStdout: true).trim()
    env.DB_PASS = sh(script: 'echo -n $DB_PASS_SECRET | base64', returnStdout: true).trim()
    env.DB_NAME = sh(script: 'echo -n $DB_NAME_SECRET | base64', returnStdout: true).trim()
    env.DB_ROOT_PASS = sh(script: 'echo -n $DB_ROOT_PASS_SECRET | base64', returnStdout: true).trim()

    echo 'deploying new release to EKS...'

    // Run kubectl commands using the correct kubeconfig
    sh "KUBECONFIG=${kubeconfigPath} envsubst < k8s-deployment/java-app-cicd.yaml | kubectl apply -f -"
    sh "KUBECONFIG=${kubeconfigPath} envsubst < k8s-deployment/db-config-cicd.yaml | kubectl apply -f -"
    sh "KUBECONFIG=${kubeconfigPath} envsubst < k8s-deployment/db-secret-cicd.yaml | kubectl apply -f -"
}

            }
        }
    }
}

```
![Bildschirmfoto 2025-05-06 um 12 18 48](https://github.com/user-attachments/assets/191e43b3-232b-4c06-b1af-ebfc0ef2c0d0)

Step 5: In step 5, I ran my pipeline and it executed successfully. Before that, I had some issues, but after adjusting my Jenkinsfile, it completed successfully.

![Bildschirmfoto 2025-05-06 um 18 31 08](https://github.com/user-attachments/assets/de2ddee3-d4b4-41d9-afd6-8336d208ed5d)

My artifacts on the ECR

![Bildschirmfoto 2025-05-06 um 18 39 20](https://github.com/user-attachments/assets/a4a98980-8a3d-444f-ad3e-34d648247df4)

![Bildschirmfoto 2025-05-06 um 18 16 11](https://github.com/user-attachments/assets/f2730dda-f6bb-4d88-be69-98087c737878)

everything was succesfully deployed on my eks cluster.

</details>






<details>
<summary>Solution 6: Configure Autoscaling </summary>
 <br>

> EXERCISE 6: Configure Autoscaling
Now your application is running, whenever a change is made, it gets automatically deployed in the cluster etc. This is great, but you notice that most of the time the 3 nodes you have are underutilized, especially at the weekends, because your containers aren't using that much resources. However, your company is paying the full price for all the servers.

- So you suggest to your manager, that you will be able to save the company some infrastructure costs, by configuring autoscaling. Your manager is happy about that and asks you to configure it.

- So go ahead and configure autoscaling to scale down to minimum 1 node when servers are underutilized and maximum 3 nodes when in full use.

Step 1: In step 1, I first created the IAM policy and the role named EKSAutoScalerRole, as described in video 3.

arn:aws:iam::524196012679:role/EKSAutoScalerRole


```sh
AutoScalerPolicy
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeScalingActivities",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeInstanceTypes",
                "ec2:DescribeLaunchTemplateVersions"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}


```

![Bildschirmfoto 2025-05-08 um 09 45 34](https://github.com/user-attachments/assets/2a73c643-8c38-448d-b9e5-c792cac326c3)

Step 2: In step 2, I created the OpenID provider.

![Bildschirmfoto 2025-05-08 um 09 42 38](https://github.com/user-attachments/assets/bd1cb8c2-fa91-4c3b-81d3-2a9122f1436f)

Step 3: In step 3, I modified the cluster-autoscaler-autodiscover.yaml file with my data, as shown in the video and deployed in my-clsuter.

```sh
---
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    k8s-addon: cluster-autoscaler.addons.k8s.io
    k8s-app: cluster-autoscaler
  name: cluster-autoscaler
  namespace: kube-system
  annotations:
    eks.amazonaws.com/role-arn: arn:aws:iam::524196012679:role/EKSAutoScalerRole

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-autoscaler
  labels:
    k8s-addon: cluster-autoscaler.addons.k8s.io
    k8s-app: cluster-autoscaler
rules:
  - apiGroups: [""]
    resources: ["events", "endpoints"]
    verbs: ["create", "patch"]
  - apiGroups: [""]
    resources: ["pods/eviction"]
    verbs: ["create"]
  - apiGroups: [""]
    resources: ["pods/status"]
    verbs: ["update"]
  - apiGroups: [""]
    resources: ["endpoints"]
    resourceNames: ["cluster-autoscaler"]
    verbs: ["get", "update"]
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["watch", "list", "get", "update"]
  - apiGroups: [""]
    resources:
      - "namespaces"
      - "pods"
      - "services"
      - "replicationcontrollers"
      - "persistentvolumeclaims"
      - "persistentvolumes"
    verbs: ["watch", "list", "get"]
  - apiGroups: ["extensions"]
    resources: ["replicasets", "daemonsets"]
    verbs: ["watch", "list", "get"]
  - apiGroups: ["policy"]
    resources: ["poddisruptionbudgets"]
    verbs: ["watch", "list"]
  - apiGroups: ["apps"]
    resources: ["statefulsets", "replicasets", "daemonsets"]
    verbs: ["watch", "list", "get"]
  - apiGroups: ["storage.k8s.io"]
    resources: ["storageclasses", "csinodes", "csidrivers", "csistoragecapacities"]
    verbs: ["watch", "list", "get"]
  - apiGroups: ["batch", "extensions"]
    resources: ["jobs"]
    verbs: ["get", "list", "watch", "patch"]
  - apiGroups: ["coordination.k8s.io"]
    resources: ["leases"]
    verbs: ["create"]
  - apiGroups: ["coordination.k8s.io"]
    resourceNames: ["cluster-autoscaler"]
    resources: ["leases"]
    verbs: ["get", "update"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: cluster-autoscaler
  namespace: kube-system
  labels:
    k8s-addon: cluster-autoscaler.addons.k8s.io
    k8s-app: cluster-autoscaler
rules:
  - apiGroups: [""]
    resources: ["configmaps"]
    verbs: ["create", "list", "watch"]
  - apiGroups: [""]
    resources: ["configmaps"]
    resourceNames: ["cluster-autoscaler-status", "cluster-autoscaler-priority-expander"]
    verbs: ["delete", "get", "update", "watch"]

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: cluster-autoscaler
  labels:
    k8s-addon: cluster-autoscaler.addons.k8s.io
    k8s-app: cluster-autoscaler
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-autoscaler
subjects:
  - kind: ServiceAccount
    name: cluster-autoscaler
    namespace: kube-system

---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: cluster-autoscaler
  namespace: kube-system
  labels:
    k8s-addon: cluster-autoscaler.addons.k8s.io
    k8s-app: cluster-autoscaler
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: cluster-autoscaler
subjects:
  - kind: ServiceAccount
    name: cluster-autoscaler
    namespace: kube-system

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cluster-autoscaler
  namespace: kube-system
  labels:
    app: cluster-autoscaler
spec:
  replicas: 1
  selector:
    matchLabels:
      app: cluster-autoscaler
  template:
    metadata:
      labels:
        app: cluster-autoscaler
      annotations:
        prometheus.io/scrape: 'true'
        prometheus.io/port: '8085'
        cluster-autoscaler.kubernetes.io/safe-to-evict: "false"
    spec:
      priorityClassName: system-cluster-critical
      securityContext:
        runAsNonRoot: true
        runAsUser: 65534
        fsGroup: 65534
        seccompProfile:
          type: RuntimeDefault
      serviceAccountName: cluster-autoscaler
      containers:
        - image: registry.k8s.io/autoscaling/cluster-autoscaler:v1.27.8
          name: cluster-autoscaler
          env:
            - name: AWS_REGION
              value: "eu-central-1"

          resources:
            limits:
              cpu: 100m
              memory: 600Mi
            requests:
              cpu: 100m
              memory: 600Mi
          command:
            - ./cluster-autoscaler
            - --v=4
            - --stderrthreshold=info
            - --cloud-provider=aws
            - --skip-nodes-with-local-storage=false
            - --expander=least-waste
            - --balance-similar-node-groups
            - --skip-nodes-with-system-pods=false
            - --node-group-auto-discovery=asg:tag=k8s.io/cluster-autoscaler/enabled,k8s.io/cluster-autoscaler/my-cluster
          volumeMounts:
            - name: ssl-certs
              mountPath: /etc/ssl/certs/ca-certificates.crt # /etc/ssl/certs/ca-bundle.crt for Amazon Linux Worker Nodes
              readOnly: true
          imagePullPolicy: "Always"
          securityContext:
            allowPrivilegeEscalation: false
            capabilities:
              drop:
                - ALL
            readOnlyRootFilesystem: true
      volumes:
        - name: ssl-certs
          hostPath:
            path: "/etc/ssl/certs/ca-bundle.crt"
```

![Bildschirmfoto 2025-05-08 um 10 16 50](https://github.com/user-attachments/assets/e0a7deb7-71fa-4298-93ed-927ccb979816)


![Bildschirmfoto 2025-05-08 um 10 25 56](https://github.com/user-attachments/assets/7f218d48-a67f-415f-9924-ebe054893ece)


![Bildschirmfoto 2025-05-08 um 10 28 57](https://github.com/user-attachments/assets/e6323cb4-4984-41ab-acd5-fff292ebe76c)


![Bildschirmfoto 2025-05-08 um 10 37 05](https://github.com/user-attachments/assets/b2b67294-6380-43a5-bfe3-61db83faa669)

![Bildschirmfoto 2025-05-08 um 10 37 21](https://github.com/user-attachments/assets/aac26130-ac7b-4384-aeec-3baeea678be7)

![Bildschirmfoto 2025-05-08 um 10 42 52](https://github.com/user-attachments/assets/2a3182c3-e5ec-4471-9deb-31290cbc2101)

Step4: In step 4, I started 20 NGINX instances, and one EC2 instance was sufficient. Then I deployed 40 NGINX instances, and the autoscaler reacted by launching another EC2 instance and distributing the load.

here my logfile from the autoscaler container: 
```sh
I0508 08:48:35.898762       1 main.go:551] Cluster Autoscaler 1.27.8
I0508 08:48:35.912583       1 leaderelection.go:245] attempting to acquire leader lease kube-system/cluster-autoscaler...
I0508 08:48:35.916707       1 leaderelection.go:349] lock is held by cluster-autoscaler-6768dd59d5-cfm9r and has not yet expired
I0508 08:48:35.916724       1 leaderelection.go:250] failed to acquire lease kube-system/cluster-autoscaler
I0508 08:48:39.445526       1 leaderelection.go:349] lock is held by cluster-autoscaler-6768dd59d5-cfm9r and has not yet expired
I0508 08:48:39.445544       1 leaderelection.go:250] failed to acquire lease kube-system/cluster-autoscaler
I0508 08:48:43.016496       1 leaderelection.go:349] lock is held by cluster-autoscaler-6768dd59d5-cfm9r and has not yet expired
I0508 08:48:43.016521       1 leaderelection.go:250] failed to acquire lease kube-system/cluster-autoscaler
I0508 08:48:47.177420       1 leaderelection.go:349] lock is held by cluster-autoscaler-6768dd59d5-cfm9r and has not yet expired
I0508 08:48:47.177438       1 leaderelection.go:250] failed to acquire lease kube-system/cluster-autoscaler
I0508 08:48:50.366404       1 leaderelection.go:349] lock is held by cluster-autoscaler-6768dd59d5-cfm9r and has not yet expired
I0508 08:48:50.366422       1 leaderelection.go:250] failed to acquire lease kube-system/cluster-autoscaler
I0508 08:48:54.631427       1 leaderelection.go:255] successfully acquired lease kube-system/cluster-autoscaler
I0508 08:48:54.631527       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Lease", Namespace:"kube-system", Name:"cluster-autoscaler", UID:"0933366b-715d-4ef8-bef8-8c22620e015d", APIVersion:"coordination.k8s.io/v1", ResourceVersion:"16068", FieldPath:""}): type: 'Normal' reason: 'LeaderElection' cluster-autoscaler-6768dd59d5-hfffq became leader
I0508 08:48:54.633490       1 reflector.go:287] Starting reflector *v1.ReplicationController (0s) from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.633507       1 reflector.go:323] Listing and watching *v1.ReplicationController from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.633758       1 reflector.go:287] Starting reflector *v1.ReplicaSet (0s) from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.633770       1 reflector.go:323] Listing and watching *v1.ReplicaSet from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.633948       1 reflector.go:287] Starting reflector *v1.Pod (0s) from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.633958       1 reflector.go:323] Listing and watching *v1.Pod from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.634215       1 reflector.go:287] Starting reflector *v1.Node (0s) from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.634226       1 reflector.go:323] Listing and watching *v1.Node from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.634397       1 reflector.go:287] Starting reflector *v1.CSIDriver (0s) from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.634408       1 reflector.go:323] Listing and watching *v1.CSIDriver from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.635256       1 reflector.go:287] Starting reflector *v1.Namespace (0s) from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.635270       1 reflector.go:323] Listing and watching *v1.Namespace from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.636011       1 reflector.go:287] Starting reflector *v1.StatefulSet (0s) from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.636027       1 reflector.go:323] Listing and watching *v1.StatefulSet from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.636855       1 reflector.go:287] Starting reflector *v1.StorageClass (0s) from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.636881       1 reflector.go:323] Listing and watching *v1.StorageClass from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.637722       1 reflector.go:287] Starting reflector *v1.CSINode (0s) from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.637732       1 reflector.go:323] Listing and watching *v1.CSINode from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.638386       1 reflector.go:287] Starting reflector *v1.CSIStorageCapacity (0s) from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.638392       1 reflector.go:323] Listing and watching *v1.CSIStorageCapacity from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.638599       1 reflector.go:287] Starting reflector *v1.PodDisruptionBudget (0s) from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.638606       1 reflector.go:323] Listing and watching *v1.PodDisruptionBudget from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.638825       1 reflector.go:287] Starting reflector *v1.Service (0s) from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.638831       1 reflector.go:323] Listing and watching *v1.Service from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.639095       1 reflector.go:287] Starting reflector *v1.PersistentVolume (0s) from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.639101       1 reflector.go:323] Listing and watching *v1.PersistentVolume from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.639669       1 reflector.go:287] Starting reflector *v1.PersistentVolumeClaim (0s) from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.639679       1 reflector.go:323] Listing and watching *v1.PersistentVolumeClaim from k8s.io/client-go/informers/factory.go:150
I0508 08:48:54.639732       1 reflector.go:287] Starting reflector *v1.Pod (1h0m0s) from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:188
I0508 08:48:54.639737       1 reflector.go:323] Listing and watching *v1.Pod from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:188
I0508 08:48:54.639795       1 reflector.go:287] Starting reflector *v1.Pod (1h0m0s) from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:212
I0508 08:48:54.639799       1 reflector.go:323] Listing and watching *v1.Pod from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:212
I0508 08:48:54.639831       1 reflector.go:287] Starting reflector *v1.Node (1h0m0s) from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:246
I0508 08:48:54.639837       1 reflector.go:323] Listing and watching *v1.Node from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:246
I0508 08:48:54.639878       1 reflector.go:287] Starting reflector *v1.Node (1h0m0s) from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:246
I0508 08:48:54.639881       1 reflector.go:323] Listing and watching *v1.Node from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:246
I0508 08:48:54.640009       1 reflector.go:287] Starting reflector *v1.PodDisruptionBudget (1h0m0s) from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:309
I0508 08:48:54.640013       1 reflector.go:323] Listing and watching *v1.PodDisruptionBudget from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:309
I0508 08:48:54.640220       1 reflector.go:287] Starting reflector *v1.DaemonSet (1h0m0s) from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:320
I0508 08:48:54.640225       1 reflector.go:323] Listing and watching *v1.DaemonSet from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:320
I0508 08:48:54.640355       1 reflector.go:287] Starting reflector *v1.ReplicationController (1h0m0s) from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:329
I0508 08:48:54.640362       1 reflector.go:323] Listing and watching *v1.ReplicationController from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:329
I0508 08:48:54.640479       1 reflector.go:287] Starting reflector *v1.Job (1h0m0s) from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:338
I0508 08:48:54.640483       1 reflector.go:323] Listing and watching *v1.Job from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:338
I0508 08:48:54.640615       1 reflector.go:287] Starting reflector *v1.ReplicaSet (1h0m0s) from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:347
I0508 08:48:54.640619       1 reflector.go:323] Listing and watching *v1.ReplicaSet from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:347
I0508 08:48:54.640799       1 reflector.go:287] Starting reflector *v1.StatefulSet (1h0m0s) from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:356
I0508 08:48:54.640803       1 reflector.go:323] Listing and watching *v1.StatefulSet from k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:356
I0508 08:48:54.896913       1 request.go:628] Waited for 258.456401ms due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/apis/storage.k8s.io/v1/csistoragecapacities?limit=500&resourceVersion=0
I0508 08:48:55.034041       1 request.go:628] Waited for 395.3416ms due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/apis/policy/v1/poddisruptionbudgets?limit=500&resourceVersion=0
I0508 08:48:55.234195       1 request.go:628] Waited for 595.267491ms due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/api/v1/services?limit=500&resourceVersion=0
I0508 08:48:55.433399       1 request.go:628] Waited for 794.164815ms due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/api/v1/persistentvolumes?limit=500&resourceVersion=0
I0508 08:48:55.633784       1 request.go:628] Waited for 994.025803ms due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/api/v1/persistentvolumeclaims?limit=500&resourceVersion=0
I0508 08:48:55.833773       1 request.go:628] Waited for 1.193944606s due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/api/v1/pods?fieldSelector=spec.nodeName%3D%2Cstatus.phase%21%3DFailed%2Cstatus.phase%21%3DSucceeded&limit=500&resourceVersion=0
I0508 08:48:55.833796       1 request.go:696] Waited for 1.193944606s due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/api/v1/pods?fieldSelector=spec.nodeName%3D%2Cstatus.phase%21%3DFailed%2Cstatus.phase%21%3DSucceeded&limit=500&resourceVersion=0
I0508 08:48:56.033896       1 request.go:628] Waited for 1.394034437s due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/api/v1/pods?fieldSelector=spec.nodeName%21%3D%2Cstatus.phase%21%3DFailed%2Cstatus.phase%21%3DSucceeded&limit=500&resourceVersion=0
I0508 08:48:56.233824       1 request.go:628] Waited for 1.593932914s due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/api/v1/nodes?limit=500&resourceVersion=0
I0508 08:48:56.433863       1 request.go:628] Waited for 1.793909594s due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/api/v1/nodes?limit=500&resourceVersion=0
I0508 08:48:56.633918       1 request.go:628] Waited for 1.99374719s due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/apis/policy/v1/poddisruptionbudgets?limit=500&resourceVersion=0
I0508 08:48:56.833786       1 request.go:628] Waited for 2.193429728s due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/apis/apps/v1/daemonsets?limit=500&resourceVersion=0
I0508 08:48:56.833810       1 request.go:696] Waited for 2.193429728s due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/apis/apps/v1/daemonsets?limit=500&resourceVersion=0
I0508 08:48:57.033396       1 request.go:628] Waited for 2.392935802s due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/api/v1/replicationcontrollers?limit=500&resourceVersion=0
I0508 08:48:57.234215       1 request.go:628] Waited for 2.593629244s due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/apis/batch/v1/jobs?limit=500&resourceVersion=0
I0508 08:48:57.434139       1 request.go:628] Waited for 2.793372456s due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/apis/apps/v1/replicasets?limit=500&resourceVersion=0
I0508 08:48:57.633812       1 request.go:628] Waited for 2.99288543s due to client-side throttling, not priority and fairness, request: GET:https://10.100.0.1:443/apis/apps/v1/statefulsets?limit=500&resourceVersion=0
I0508 08:48:57.834274       1 request.go:628] Waited for 2.939577054s due to client-side throttling, not priority and fairness, request: POST:https://10.100.0.1:443/api/v1/namespaces/kube-system/configmaps
I0508 08:48:57.834294       1 request.go:696] Waited for 2.939577054s due to client-side throttling, not priority and fairness, request: POST:https://10.100.0.1:443/api/v1/namespaces/kube-system/configmaps
I0508 08:48:57.844139       1 cloud_provider_builder.go:29] Building aws cloud provider.
I0508 08:49:01.800717       1 aws_cloud_provider.go:422] Using static instance type x2gd.4xlarge
I0508 08:49:01.800753       1 aws_cloud_provider.go:422] Using static instance type u-24tb1.112xlarge
I0508 08:49:01.800784       1 aws_cloud_provider.go:422] Using static instance type h1.16xlarge
I0508 08:49:01.800800       1 aws_cloud_provider.go:422] Using static instance type x2iezn.2xlarge
I0508 08:49:01.800810       1 aws_cloud_provider.go:422] Using static instance type mac2.metal
I0508 08:49:01.800823       1 aws_cloud_provider.go:422] Using static instance type g3s.xlarge
I0508 08:49:01.800833       1 aws_cloud_provider.go:422] Using static instance type x2gd.12xlarge
I0508 08:49:01.800845       1 aws_cloud_provider.go:422] Using static instance type x2gd.16xlarge
I0508 08:49:01.800865       1 aws_cloud_provider.go:422] Using static instance type m2.4xlarge
I0508 08:49:01.800883       1 aws_cloud_provider.go:422] Using static instance type m1.xlarge
I0508 08:49:01.800895       1 aws_cloud_provider.go:422] Using static instance type g3.16xlarge
I0508 08:49:01.800907       1 aws_cloud_provider.go:422] Using static instance type c1.xlarge
I0508 08:49:01.800927       1 aws_cloud_provider.go:422] Using static instance type vt1.6xlarge
I0508 08:49:01.800937       1 aws_cloud_provider.go:422] Using static instance type g2.8xlarge
I0508 08:49:01.800953       1 aws_cloud_provider.go:422] Using static instance type p5.48xlarge
I0508 08:49:01.800965       1 aws_cloud_provider.go:422] Using static instance type p3dn.24xlarge
I0508 08:49:01.800978       1 aws_cloud_provider.go:422] Using static instance type p2.xlarge
I0508 08:49:01.800990       1 aws_cloud_provider.go:422] Using static instance type h1.8xlarge
I0508 08:49:01.801003       1 aws_cloud_provider.go:422] Using static instance type cc2.8xlarge
I0508 08:49:01.801020       1 aws_cloud_provider.go:422] Using static instance type x2gd.large
I0508 08:49:01.801035       1 aws_cloud_provider.go:422] Using static instance type t1.micro
I0508 08:49:01.801050       1 aws_cloud_provider.go:422] Using static instance type m1.small
I0508 08:49:01.801065       1 aws_cloud_provider.go:422] Using static instance type m1.large
I0508 08:49:01.801078       1 aws_cloud_provider.go:422] Using static instance type h1.4xlarge
I0508 08:49:01.801091       1 aws_cloud_provider.go:422] Using static instance type dl1.24xlarge
I0508 08:49:01.801102       1 aws_cloud_provider.go:422] Using static instance type x2gd.xlarge
I0508 08:49:01.801121       1 aws_cloud_provider.go:422] Using static instance type x2gd.2xlarge
I0508 08:49:01.801134       1 aws_cloud_provider.go:422] Using static instance type p4de.24xlarge
I0508 08:49:01.801146       1 aws_cloud_provider.go:422] Using static instance type vt1.24xlarge
I0508 08:49:01.801160       1 aws_cloud_provider.go:422] Using static instance type vt1.3xlarge
I0508 08:49:01.801176       1 aws_cloud_provider.go:422] Using static instance type g2.2xlarge
I0508 08:49:01.801189       1 aws_cloud_provider.go:422] Using static instance type x2iezn.6xlarge
I0508 08:49:01.801198       1 aws_cloud_provider.go:422] Using static instance type x2iezn.8xlarge
I0508 08:49:01.801214       1 aws_cloud_provider.go:422] Using static instance type m2.xlarge
I0508 08:49:01.801225       1 aws_cloud_provider.go:422] Using static instance type x2gd.medium
I0508 08:49:01.801237       1 aws_cloud_provider.go:422] Using static instance type g3.8xlarge
I0508 08:49:01.801249       1 aws_cloud_provider.go:422] Using static instance type c1.medium
I0508 08:49:01.801263       1 aws_cloud_provider.go:422] Using static instance type p2.8xlarge
I0508 08:49:01.801278       1 aws_cloud_provider.go:422] Using static instance type x2iezn.4xlarge
I0508 08:49:01.801290       1 aws_cloud_provider.go:422] Using static instance type trn1.2xlarge
I0508 08:49:01.801318       1 aws_cloud_provider.go:422] Using static instance type m2.2xlarge
I0508 08:49:01.801332       1 aws_cloud_provider.go:422] Using static instance type trn1.32xlarge
I0508 08:49:01.801346       1 aws_cloud_provider.go:422] Using static instance type g3.4xlarge
I0508 08:49:01.801357       1 aws_cloud_provider.go:422] Using static instance type x2gd.metal
I0508 08:49:01.801372       1 aws_cloud_provider.go:422] Using static instance type h1.2xlarge
I0508 08:49:01.801380       1 aws_cloud_provider.go:422] Using static instance type x2gd.8xlarge
I0508 08:49:01.801391       1 aws_cloud_provider.go:422] Using static instance type p2.16xlarge
I0508 08:49:01.801402       1 aws_cloud_provider.go:422] Using static instance type x2iezn.12xlarge
I0508 08:49:01.801417       1 aws_cloud_provider.go:422] Using static instance type x2iezn.metal
I0508 08:49:01.801428       1 aws_cloud_provider.go:422] Using static instance type m1.medium
I0508 08:49:01.801437       1 aws_cloud_provider.go:422] Using static instance type f1.16xlarge
I0508 08:49:01.801511       1 aws_cloud_provider.go:432] Successfully load 882 EC2 Instance Types [m8gd.large c8g.16xlarge x2gd.metal mac2.metal x8g.metal-24xl c7a.48xlarge i3.16xlarge r6id.8xlarge r5n.metal inf1.24xlarge m6g.4xlarge r8gd.metal-48xl dl1.24xlarge m5n.xlarge r7g.16xlarge r7i.metal-48xl t2.micro r6g.12xlarge r7g.xlarge g5.xlarge x8g.4xlarge r6gd.12xlarge c7i-flex.8xlarge m5.metal c5.12xlarge t3a.micro r6i.metal m8gd.16xlarge c6gd.metal m8g.16xlarge c7a.24xlarge m5d.2xlarge inf2.24xlarge inf1.2xlarge c8gd.8xlarge g6e.48xlarge r6in.xlarge c6in.24xlarge m6i.large c8g.metal-48xl m7a.4xlarge c5.metal g3.4xlarge m5d.xlarge m7i-flex.12xlarge r5a.large c4.large m5a.4xlarge m6gd.metal c7g.medium c6in.metal r8gd.metal-24xl c5.24xlarge r6a.24xlarge c7g.large x8g.2xlarge t4g.medium r7gd.xlarge c6gd.16xlarge r5ad.12xlarge m5d.large m6a.metal r5n.large r5d.24xlarge m7i-flex.2xlarge c6gn.medium m6i.16xlarge r5b.4xlarge i7ie.24xlarge m6idn.2xlarge m8g.48xlarge m5n.16xlarge z1d.metal vt1.6xlarge c4.4xlarge r7a.24xlarge m7i.large i3.4xlarge c6id.xlarge c5d.large r6in.32xlarge m5d.12xlarge c5d.9xlarge m5zn.12xlarge x2iedn.16xlarge r5dn.8xlarge c6id.16xlarge m7g.16xlarge m5zn.metal c5.2xlarge m6a.xlarge r6in.12xlarge m7a.xlarge r7a.medium i8g.8xlarge m5d.24xlarge c7i.4xlarge c6gd.12xlarge t3a.small c5ad.xlarge r7i.4xlarge c7a.12xlarge is4gen.4xlarge m6id.32xlarge c8g.24xlarge r5dn.xlarge c5n.large r6gd.xlarge m7a.large r6g.16xlarge is4gen.xlarge c7a.large r5dn.16xlarge r7gd.16xlarge t3a.nano r6a.2xlarge t2.medium x8g.8xlarge x2iezn.4xlarge r7a.2xlarge c7g.16xlarge r8gd.16xlarge r7a.48xlarge g5g.4xlarge r6in.metal m6idn.4xlarge r7a.large c6in.12xlarge z1d.2xlarge i3.8xlarge is4gen.8xlarge m7i.metal-24xl r7iz.2xlarge p4d.24xlarge c5a.xlarge x2iezn.2xlarge r5.24xlarge g4ad.2xlarge c7gd.4xlarge i4i.32xlarge x1.32xlarge i2.2xlarge r5.metal m5n.8xlarge c6g.2xlarge c8gd.metal-24xl m5a.xlarge m6a.8xlarge x2iedn.8xlarge t1.micro im4gn.2xlarge r6id.12xlarge r7a.12xlarge g4dn.8xlarge d3.xlarge r5d.2xlarge r6id.metal c4.xlarge c6i.8xlarge g6e.16xlarge m6i.metal r5ad.2xlarge m6g.large m7i.metal-48xl m6id.12xlarge r6g.metal r8gd.xlarge r8gd.8xlarge g6.12xlarge gr6.8xlarge r6idn.2xlarge z1d.xlarge u-12tb1.112xlarge m6idn.metal r6id.16xlarge c6gd.8xlarge f1.4xlarge m5dn.2xlarge c6gn.12xlarge t3.small m5ad.8xlarge m5.16xlarge i3.2xlarge r6id.xlarge c5d.12xlarge r4.16xlarge p3.8xlarge c5n.metal m5.large r5a.2xlarge r7gd.large m7gd.12xlarge m5n.metal m3.xlarge c8g.8xlarge m2.2xlarge x2iedn.xlarge r5a.12xlarge x2gd.2xlarge m4.xlarge c6id.metal c6i.12xlarge r7iz.metal-16xl i4i.8xlarge r6gd.medium c7i.24xlarge c7gd.xlarge g3.8xlarge m5ad.2xlarge m7a.medium t3.micro m6a.24xlarge x2gd.medium m8g.24xlarge c6in.large g5g.8xlarge r6a.16xlarge c8gd.48xlarge i7ie.18xlarge r7iz.12xlarge u-6tb1.56xlarge m5ad.16xlarge c6i.xlarge m6id.large m6id.24xlarge c7i.8xlarge r7i.16xlarge m8gd.48xlarge c8gd.16xlarge inf1.6xlarge c5.4xlarge r5b.12xlarge r6g.large m5d.16xlarge r6in.16xlarge c6a.16xlarge r5.4xlarge r5d.8xlarge i3en.2xlarge r6id.4xlarge r6id.large r7i.large r6i.32xlarge i4i.4xlarge m6gd.8xlarge x2iezn.metal r7g.large m3.medium g3s.xlarge c8gd.24xlarge c5d.18xlarge c7g.2xlarge r5a.8xlarge c8g.2xlarge r7g.medium m7a.16xlarge c6i.16xlarge g5.16xlarge c8g.xlarge i3en.3xlarge r6a.large c5n.xlarge c6gd.2xlarge r8g.large r5.16xlarge i3en.large r7iz.metal-32xl c5d.metal x2iedn.24xlarge c3.2xlarge i3en.xlarge m7a.metal-48xl x2iezn.12xlarge m7i-flex.4xlarge c6in.xlarge r5ad.24xlarge c6g.16xlarge c5ad.8xlarge c6a.metal c7gd.metal m8gd.metal-24xl g4ad.4xlarge x1e.4xlarge m6in.large c7g.4xlarge c6i.24xlarge p3.2xlarge m8g.2xlarge i8g.16xlarge t2.2xlarge d2.xlarge g5g.metal r5ad.4xlarge c5ad.24xlarge d3.8xlarge i7ie.3xlarge c5a.4xlarge m6a.12xlarge i7ie.6xlarge r7iz.large c7a.4xlarge c5ad.2xlarge c7g.metal m6i.2xlarge r6a.4xlarge i4i.xlarge c6a.32xlarge x8g.metal-48xl r5d.12xlarge g4dn.4xlarge g6.24xlarge r6gd.metal i2.8xlarge m5a.12xlarge m6id.2xlarge c5n.9xlarge c6in.4xlarge m5d.4xlarge m5ad.12xlarge m6i.8xlarge c5n.4xlarge im4gn.large i7ie.large m7i.4xlarge i3en.metal m8g.metal-24xl m7i.24xlarge c7g.xlarge c7gd.16xlarge m6id.metal m7a.24xlarge m6in.2xlarge m7i.8xlarge x2idn.24xlarge r5n.4xlarge g5g.xlarge g4dn.2xlarge c6a.large m7gd.16xlarge r7g.2xlarge m6idn.16xlarge r8gd.2xlarge r3.2xlarge i8g.xlarge t4g.micro m6idn.8xlarge r5d.xlarge x1e.16xlarge r5a.24xlarge c6i.large c6gn.xlarge r6id.24xlarge r7a.xlarge c4.8xlarge c8gd.medium r6idn.large r5dn.4xlarge g2.8xlarge r4.xlarge c6a.4xlarge m5ad.xlarge r8g.16xlarge r5n.2xlarge r8g.metal-48xl r5n.24xlarge r7gd.4xlarge c7gd.medium x8g.large m5zn.6xlarge a1.medium m8g.medium r6a.32xlarge inf2.48xlarge r6gd.large is4gen.large m8g.4xlarge r7g.4xlarge g6.2xlarge r6idn.12xlarge m6gd.12xlarge r3.8xlarge r7g.metal g6.xlarge im4gn.8xlarge d3en.6xlarge c8gd.xlarge d3.2xlarge inf2.xlarge r6g.8xlarge d2.4xlarge r5n.8xlarge m5ad.24xlarge r7gd.2xlarge g6e.8xlarge c6a.48xlarge r7a.8xlarge i4i.2xlarge mac2-m2.metal x8g.48xlarge c7i-flex.xlarge r7i.metal-24xl m5dn.4xlarge r7iz.16xlarge i7ie.metal-48xl r5b.large m7i-flex.xlarge r7i.24xlarge m7g.large c7gd.large i7ie.12xlarge r6gd.2xlarge r6i.large c3.xlarge trn1.32xlarge r7i.2xlarge r6idn.4xlarge m5.4xlarge m6g.2xlarge r6i.24xlarge r6idn.32xlarge is4gen.medium r7i.xlarge r7gd.12xlarge r8gd.48xlarge m5n.4xlarge r4.4xlarge d2.2xlarge m6gd.16xlarge r4.large p2.16xlarge r6in.large a1.xlarge m7g.xlarge m7a.8xlarge r6g.4xlarge r7a.metal-48xl d3en.xlarge c6g.12xlarge r7i.12xlarge c6g.large i8g.24xlarge m7a.32xlarge mac1.metal u-6tb1.112xlarge c8gd.metal-48xl g6e.24xlarge m6gd.xlarge c5d.xlarge r7g.12xlarge vt1.3xlarge d3en.2xlarge m7gd.metal i8g.large g6.16xlarge m6a.large c6id.large r8g.24xlarge inf2.8xlarge r7gd.metal gr6.4xlarge c1.medium i3en.12xlarge r6g.medium r5dn.24xlarge m6in.32xlarge m4.large m7i-flex.16xlarge m4.10xlarge m8g.8xlarge c5d.4xlarge m8gd.medium d2.8xlarge u-3tb1.56xlarge c5a.16xlarge m2.4xlarge c7gd.8xlarge x2iedn.2xlarge m6a.16xlarge r5d.16xlarge r5.xlarge u-18tb1.112xlarge r6idn.24xlarge m7g.medium u-24tb1.112xlarge m6g.12xlarge c7a.medium m6g.metal i8g.2xlarge r8gd.24xlarge c5ad.4xlarge r6i.4xlarge m7g.8xlarge m8gd.12xlarge r6idn.8xlarge d3en.4xlarge x2idn.16xlarge m8g.metal-48xl m8g.xlarge g6.4xlarge m6idn.32xlarge t4g.large x2iedn.32xlarge c3.large c6id.24xlarge g6.8xlarge c7i.large c7i.xlarge r5b.8xlarge m7i-flex.large m1.medium c6id.8xlarge r6idn.16xlarge m7gd.xlarge x8g.12xlarge r5d.4xlarge r7gd.medium r6in.24xlarge m5n.12xlarge r5dn.metal i4i.large c6gn.8xlarge m6a.2xlarge r6idn.xlarge g6.48xlarge c5ad.16xlarge c7g.12xlarge c6in.32xlarge c5a.large h1.8xlarge m7a.12xlarge g3.16xlarge r5a.16xlarge c6in.2xlarge t2.small h1.4xlarge r5a.4xlarge m7i.xlarge i3.xlarge t2.nano c6g.metal m8gd.24xlarge m7g.2xlarge m5n.24xlarge m7g.4xlarge c8g.48xlarge r5dn.large r8g.48xlarge m6in.xlarge m4.16xlarge r8g.4xlarge m5ad.large i4i.metal g4dn.metal m6gd.large c5ad.12xlarge r6in.4xlarge m5.2xlarge i3.metal g5.4xlarge c6i.32xlarge m6in.16xlarge m8gd.2xlarge x1.16xlarge m6id.4xlarge r7a.4xlarge r5.large x8g.24xlarge m6idn.24xlarge t3a.large c6g.xlarge im4gn.16xlarge t2.xlarge c6g.medium c6g.8xlarge x2gd.xlarge m5.8xlarge m5zn.2xlarge r6id.32xlarge z1d.12xlarge t4g.2xlarge g4ad.xlarge d3en.12xlarge cc2.8xlarge t3.2xlarge g4dn.12xlarge m6i.4xlarge m6g.16xlarge x1e.2xlarge g5g.2xlarge r6i.16xlarge i7ie.metal-24xl c6gd.4xlarge c5a.24xlarge m6id.16xlarge m3.2xlarge p3.16xlarge p2.8xlarge t3a.2xlarge m5a.8xlarge m6i.32xlarge c8g.4xlarge i8g.4xlarge r3.4xlarge m6i.24xlarge m6in.24xlarge c5a.2xlarge r6g.2xlarge c7a.32xlarge c6id.4xlarge inf1.xlarge m7gd.8xlarge r5b.2xlarge r5ad.large x1e.8xlarge x2idn.metal r6i.12xlarge c8gd.large m6in.metal im4gn.4xlarge r8g.8xlarge r5a.xlarge g5.12xlarge m6in.4xlarge r6idn.metal t4g.nano m8gd.8xlarge r8gd.large c5.large c5.9xlarge dl2q.24xlarge i3en.6xlarge m1.small m6idn.12xlarge r7iz.32xlarge x2iedn.metal t2.large r5.12xlarge r6i.2xlarge m5a.24xlarge z1d.3xlarge m6g.8xlarge x2idn.32xlarge c3.4xlarge x1e.xlarge c7g.8xlarge m5zn.3xlarge c6in.8xlarge c8g.12xlarge c7i.48xlarge c6gd.large p5.48xlarge r5n.12xlarge c6id.12xlarge m7i.12xlarge r7a.32xlarge u-9tb1.112xlarge f1.2xlarge c7i-flex.2xlarge r6gd.8xlarge h1.2xlarge r8g.medium m7gd.2xlarge r5b.16xlarge m8gd.xlarge r8gd.12xlarge r7i.48xlarge c6a.12xlarge m5dn.metal r8g.xlarge vt1.24xlarge r6a.xlarge m5dn.12xlarge c5d.24xlarge g6e.12xlarge r5n.16xlarge m6id.8xlarge r8g.2xlarge x8g.xlarge m6gd.4xlarge m5d.metal c8g.large i4i.16xlarge c6i.2xlarge r7g.8xlarge i4i.24xlarge c4.2xlarge c1.xlarge m5.12xlarge i7ie.xlarge t4g.xlarge c7i-flex.16xlarge r5b.metal x2iezn.8xlarge trn1.2xlarge m7gd.4xlarge m6gd.2xlarge i7ie.2xlarge x2gd.16xlarge c7a.metal-48xl c5.xlarge r7a.16xlarge g2.2xlarge r8g.metal-24xl m6idn.large r5n.xlarge p4de.24xlarge c5n.2xlarge is4gen.2xlarge t4g.small m1.large c7i-flex.4xlarge x8g.16xlarge i8g.metal-24xl c8g.medium r6g.xlarge g5.24xlarge c6id.2xlarge m6in.8xlarge z1d.6xlarge c7a.2xlarge r5b.24xlarge c5a.12xlarge x8g.medium m5n.large m2.xlarge t3.nano r7iz.xlarge c7i-flex.large c7i.metal-48xl m5a.2xlarge c7i.2xlarge r6a.12xlarge r8gd.medium g4dn.16xlarge m6a.32xlarge x2gd.4xlarge c7gd.2xlarge c7a.16xlarge c6i.4xlarge r5dn.2xlarge g6e.4xlarge c7a.xlarge m5a.16xlarge m8gd.4xlarge d3.4xlarge g5.8xlarge r6id.2xlarge m7g.12xlarge r4.2xlarge m5dn.16xlarge r8g.12xlarge r5.2xlarge m3.large m6g.xlarge m1.xlarge p3dn.24xlarge c7a.8xlarge m7i.48xlarge a1.metal x2gd.8xlarge m7gd.large c3.8xlarge m6gd.medium t3.large r5dn.12xlarge r5d.metal r7iz.8xlarge r3.large g4dn.xlarge m5a.large z1d.large r3.xlarge g4ad.8xlarge c5a.8xlarge g5.2xlarge r5.8xlarge i3.large t3a.xlarge i2.4xlarge m6id.xlarge i2.xlarge c6gd.medium m5dn.24xlarge c7i.metal-24xl t3a.medium c7i.16xlarge c5d.2xlarge r5ad.8xlarge m8g.12xlarge a1.4xlarge c6g.4xlarge c6gn.large r7iz.4xlarge m5n.2xlarge g6e.2xlarge m7g.metal m5d.8xlarge m5.24xlarge m5zn.large c6in.16xlarge m5dn.xlarge g5g.16xlarge m6i.xlarge c5ad.large m5.xlarge m7gd.medium m6idn.xlarge c8gd.12xlarge c8gd.2xlarge r6gd.16xlarge g4ad.16xlarge i3en.24xlarge c8g.metal-24xl c6a.2xlarge c7gd.12xlarge m4.4xlarge c6a.xlarge t3.xlarge r6gd.4xlarge m7a.48xlarge c6gn.16xlarge m7i.2xlarge c8gd.4xlarge r5ad.16xlarge m7i-flex.8xlarge c6gn.2xlarge i4i.12xlarge m8gd.metal-48xl a1.large r6a.8xlarge c5.18xlarge c6a.24xlarge m5ad.4xlarge c6a.8xlarge m6g.medium c6gd.xlarge m5dn.large x1e.32xlarge m8g.large f1.16xlarge im4gn.xlarge c7i-flex.12xlarge r6in.8xlarge m5dn.8xlarge c6id.32xlarge x2iedn.4xlarge m4.2xlarge r6i.8xlarge c5n.18xlarge m5zn.xlarge x2iezn.6xlarge c6gn.4xlarge t3.medium g6e.xlarge x2gd.large r6a.metal r5d.large g5.48xlarge h1.16xlarge r6a.48xlarge r4.8xlarge d3en.8xlarge r7gd.8xlarge r7i.8xlarge r6i.xlarge a1.2xlarge m6i.12xlarge x2gd.12xlarge i7ie.48xlarge m6a.4xlarge p2.xlarge m7i.16xlarge r5b.xlarge c6i.metal i8g.12xlarge c7i.12xlarge r6in.2xlarge m6a.48xlarge m6in.12xlarge r8gd.4xlarge r5ad.xlarge m7a.2xlarge]
I0508 08:49:01.801698       1 aws_manager.go:79] AWS SDK Version: 1.48.7
I0508 08:49:01.801789       1 auto_scaling_groups.go:369] Regenerating instance to ASG map for ASG names: []
I0508 08:49:01.801802       1 auto_scaling_groups.go:376] Regenerating instance to ASG map for ASG tags: map[k8s.io/cluster-autoscaler/enabled: k8s.io/cluster-autoscaler/my-cluster:]
I0508 08:49:01.987280       1 auto_scaling_groups.go:163] Registering ASG eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788
I0508 08:49:01.987309       1 aws_wrapper.go:703] 0 launch configurations to query
I0508 08:49:01.987315       1 aws_wrapper.go:704] 0 launch templates to query
I0508 08:49:01.987322       1 aws_wrapper.go:724] Successfully queried 0 launch configurations
I0508 08:49:01.987328       1 aws_wrapper.go:735] Successfully queried 0 launch templates
I0508 08:49:01.987335       1 aws_wrapper.go:746] Successfully queried instance requirements for 0 ASGs
I0508 08:49:01.987349       1 auto_scaling_groups.go:427] Extracted autoscaling options from "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788" ASG tags: map[]
I0508 08:49:01.987364       1 aws_manager.go:132] Refreshed ASG list, next refresh after 2025-05-08 08:50:01.987359968 +0000 UTC m=+86.779430983
I0508 08:49:01.987625       1 main.go:402] Registered cleanup signal handler
I0508 08:49:01.987676       1 node_instances_cache.go:156] Start refreshing cloud provider node instances cache
I0508 08:49:01.987695       1 node_instances_cache.go:168] Refresh cloud provider node instances cache finished, refresh took 7.044µs
I0508 08:49:11.987794       1 static_autoscaler.go:289] Starting main loop
I0508 08:49:11.988253       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
E0508 08:49:12.070870       1 managed_nodegroup_cache.go:136] Failed to query the managed nodegroup ng-cc1c9586 for the cluster my-cluster while looking for labels/taints/tags: AccessDeniedException: User: arn:aws:sts::524196012679:assumed-role/EKSAutoScalerRole/1746694137844533326 is not authorized to perform: eks:DescribeNodegroup on resource: arn:aws:eks:eu-central-1:524196012679:nodegroup/my-cluster/ng-cc1c9586/e0cb5767-5310-8285-c96d-77388791a788
E0508 08:49:12.070897       1 aws_manager.go:299] Failed to get labels from EKS DescribeNodegroup API for nodegroup ng-cc1c9586 in cluster my-cluster because AccessDeniedException: User: arn:aws:sts::524196012679:assumed-role/EKSAutoScalerRole/1746694137844533326 is not authorized to perform: eks:DescribeNodegroup on resource: arn:aws:eks:eu-central-1:524196012679:nodegroup/my-cluster/ng-cc1c9586/e0cb5767-5310-8285-c96d-77388791a788.
W0508 08:49:12.071075       1 clusterstate.go:444] AcceptableRanges have not been populated yet. Skip checking
I0508 08:49:12.071231       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:49:12.071247       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:49:12.071287       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:49:12.071295       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:49:12.071300       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:49:12.071327       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:49:12.071350       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:49:12.071374       1 pre_filtering_processor.go:67] Skipping ip-192-168-17-5.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:12.071390       1 pre_filtering_processor.go:67] Skipping ip-192-168-47-237.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:12.071402       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:12.071514       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:49:12.071552       1 static_autoscaler.go:649] Starting scale down
I0508 08:49:12.071580       1 legacy.go:296] No candidates for scale down
I0508 08:49:22.085579       1 static_autoscaler.go:289] Starting main loop
I0508 08:49:22.086029       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:49:22.086274       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:49:22.086291       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:49:22.086302       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:49:22.086308       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:49:22.086312       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:49:22.086338       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:49:22.086363       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:49:22.086381       1 pre_filtering_processor.go:67] Skipping ip-192-168-17-5.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:22.086391       1 pre_filtering_processor.go:67] Skipping ip-192-168-47-237.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:22.086400       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:22.086442       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:49:22.086481       1 static_autoscaler.go:649] Starting scale down
I0508 08:49:22.086506       1 legacy.go:296] No candidates for scale down
I0508 08:49:32.101506       1 static_autoscaler.go:289] Starting main loop
I0508 08:49:32.101908       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:49:32.102157       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:49:32.102173       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:49:32.102185       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:49:32.102191       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:49:32.102197       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:49:32.102225       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:49:32.102246       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:49:32.102265       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:32.102279       1 pre_filtering_processor.go:67] Skipping ip-192-168-17-5.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:32.102289       1 pre_filtering_processor.go:67] Skipping ip-192-168-47-237.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:32.102324       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:49:32.102361       1 static_autoscaler.go:649] Starting scale down
I0508 08:49:32.102387       1 legacy.go:296] No candidates for scale down
I0508 08:49:42.114047       1 static_autoscaler.go:289] Starting main loop
I0508 08:49:42.114515       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:49:42.114747       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:49:42.114765       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:49:42.114776       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:49:42.114784       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:49:42.114790       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:49:42.114815       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:49:42.114840       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:49:42.114859       1 pre_filtering_processor.go:67] Skipping ip-192-168-17-5.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:42.114870       1 pre_filtering_processor.go:67] Skipping ip-192-168-47-237.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:42.114886       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:42.114929       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:49:42.114972       1 static_autoscaler.go:649] Starting scale down
I0508 08:49:42.115011       1 legacy.go:296] No candidates for scale down
I0508 08:49:52.127359       1 static_autoscaler.go:289] Starting main loop
I0508 08:49:52.127738       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:49:52.127942       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:49:52.127957       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:49:52.127968       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:49:52.127974       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:49:52.127979       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:49:52.128003       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:49:52.128026       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:49:52.128038       1 pre_filtering_processor.go:67] Skipping ip-192-168-17-5.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:52.128045       1 pre_filtering_processor.go:67] Skipping ip-192-168-47-237.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:52.128054       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:49:52.128081       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:49:52.128105       1 static_autoscaler.go:649] Starting scale down
I0508 08:49:52.128121       1 legacy.go:296] No candidates for scale down
I0508 08:50:02.141781       1 static_autoscaler.go:289] Starting main loop
I0508 08:50:02.141857       1 auto_scaling_groups.go:369] Regenerating instance to ASG map for ASG names: []
I0508 08:50:02.141871       1 auto_scaling_groups.go:376] Regenerating instance to ASG map for ASG tags: map[k8s.io/cluster-autoscaler/enabled: k8s.io/cluster-autoscaler/my-cluster:]
I0508 08:50:02.316135       1 aws_wrapper.go:703] 0 launch configurations to query
I0508 08:50:02.316154       1 aws_wrapper.go:704] 0 launch templates to query
I0508 08:50:02.316162       1 aws_wrapper.go:724] Successfully queried 0 launch configurations
I0508 08:50:02.316170       1 aws_wrapper.go:735] Successfully queried 0 launch templates
I0508 08:50:02.316178       1 aws_wrapper.go:746] Successfully queried instance requirements for 0 ASGs
I0508 08:50:02.316189       1 aws_manager.go:132] Refreshed ASG list, next refresh after 2025-05-08 08:51:02.316185683 +0000 UTC m=+147.108256704
I0508 08:50:02.316582       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:50:02.316782       1 clusterstate.go:1016] Failed to check cloud provider has instance for ip-192-168-47-237.eu-central-1.compute.internal: node is not present in aws: could not find instance {aws:///eu-central-1c/i-0acbc17d8156cf259 i-0acbc17d8156cf259}
I0508 08:50:02.316856       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:50:02.316866       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:50:02.316876       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:50:02.316882       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:50:02.316887       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:50:02.316911       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:50:02.316930       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:50:02.316943       1 pre_filtering_processor.go:57] Node ip-192-168-47-237.eu-central-1.compute.internal should not be processed by cluster autoscaler (no node group config)
I0508 08:50:02.316953       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:50:02.316964       1 pre_filtering_processor.go:67] Skipping ip-192-168-17-5.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:50:02.316998       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:50:02.317029       1 static_autoscaler.go:649] Starting scale down
I0508 08:50:02.317049       1 legacy.go:296] No candidates for scale down
I0508 08:50:12.337147       1 static_autoscaler.go:289] Starting main loop
I0508 08:50:12.337599       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:50:12.337779       1 clusterstate.go:1016] Failed to check cloud provider has instance for ip-192-168-47-237.eu-central-1.compute.internal: node is not present in aws: could not find instance {aws:///eu-central-1c/i-0acbc17d8156cf259 i-0acbc17d8156cf259}
I0508 08:50:12.337837       1 static_autoscaler.go:407] 1 unregistered nodes present
I0508 08:50:12.337862       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:50:12.337871       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:50:12.337882       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:50:12.337888       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:50:12.337894       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:50:12.337919       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:50:12.337940       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:50:12.337956       1 pre_filtering_processor.go:57] Node ip-192-168-47-237.eu-central-1.compute.internal should not be processed by cluster autoscaler (no node group config)
I0508 08:50:12.337973       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:50:12.338014       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:50:12.338049       1 static_autoscaler.go:649] Starting scale down
I0508 08:50:12.338070       1 legacy.go:296] No candidates for scale down
I0508 08:50:22.352557       1 static_autoscaler.go:289] Starting main loop
I0508 08:50:22.352886       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:50:22.353065       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1c/i-0acbc17d8156cf259
I0508 08:50:22.353103       1 static_autoscaler.go:407] 2 unregistered nodes present
W0508 08:50:22.353123       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1c/i-0acbc17d8156cf259, skipping
I0508 08:50:22.353144       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:50:22.353151       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:50:22.353158       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:50:22.353163       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:50:22.353168       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:50:22.353186       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:50:22.353198       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:50:22.353209       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:50:22.353232       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:50:22.353258       1 static_autoscaler.go:649] Starting scale down
I0508 08:50:22.353274       1 legacy.go:296] No candidates for scale down
I0508 08:50:32.367389       1 static_autoscaler.go:289] Starting main loop
I0508 08:50:32.367701       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:50:32.367888       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1c/i-0acbc17d8156cf259
I0508 08:50:32.367924       1 static_autoscaler.go:407] 2 unregistered nodes present
W0508 08:50:32.367946       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1c/i-0acbc17d8156cf259, skipping
I0508 08:50:32.367970       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:50:32.367982       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:50:32.367996       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:50:32.368002       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:50:32.368008       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:50:32.368034       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:50:32.368053       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:50:32.368070       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:50:32.368105       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:50:32.368138       1 static_autoscaler.go:649] Starting scale down
I0508 08:50:32.368159       1 legacy.go:296] No candidates for scale down
I0508 08:50:42.384770       1 static_autoscaler.go:289] Starting main loop
I0508 08:50:42.385187       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:50:42.385408       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1c/i-0acbc17d8156cf259
I0508 08:50:42.385448       1 static_autoscaler.go:407] 2 unregistered nodes present
W0508 08:50:42.385467       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1c/i-0acbc17d8156cf259, skipping
I0508 08:50:42.385494       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:50:42.385511       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:50:42.385527       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:50:42.385536       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:50:42.385542       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:50:42.385567       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:50:42.385589       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:50:42.385606       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:50:42.385644       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:50:42.385680       1 static_autoscaler.go:649] Starting scale down
I0508 08:50:42.385708       1 legacy.go:296] No candidates for scale down
I0508 08:50:52.398431       1 static_autoscaler.go:289] Starting main loop
I0508 08:50:52.398786       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:50:52.398952       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1c/i-0acbc17d8156cf259
I0508 08:50:52.399005       1 static_autoscaler.go:407] 2 unregistered nodes present
W0508 08:50:52.399025       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1c/i-0acbc17d8156cf259, skipping
I0508 08:50:52.399049       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:50:52.399062       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:50:52.399073       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:50:52.399080       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:50:52.399087       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:50:52.399110       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:50:52.399130       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:50:52.399149       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:50:52.399181       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:50:52.399214       1 static_autoscaler.go:649] Starting scale down
I0508 08:50:52.399239       1 legacy.go:296] No candidates for scale down
I0508 08:51:01.987929       1 node_instances_cache.go:156] Start refreshing cloud provider node instances cache
I0508 08:51:01.987960       1 node_instances_cache.go:168] Refresh cloud provider node instances cache finished, refresh took 10.942µs
I0508 08:51:02.410492       1 static_autoscaler.go:289] Starting main loop
I0508 08:51:02.410547       1 auto_scaling_groups.go:369] Regenerating instance to ASG map for ASG names: []
I0508 08:51:02.410563       1 auto_scaling_groups.go:376] Regenerating instance to ASG map for ASG tags: map[k8s.io/cluster-autoscaler/enabled: k8s.io/cluster-autoscaler/my-cluster:]
I0508 08:51:02.533422       1 aws_wrapper.go:703] 0 launch configurations to query
I0508 08:51:02.533439       1 aws_wrapper.go:704] 0 launch templates to query
I0508 08:51:02.533445       1 aws_wrapper.go:724] Successfully queried 0 launch configurations
I0508 08:51:02.533451       1 aws_wrapper.go:735] Successfully queried 0 launch templates
I0508 08:51:02.533516       1 aws_wrapper.go:746] Successfully queried instance requirements for 0 ASGs
I0508 08:51:02.533530       1 aws_manager.go:132] Refreshed ASG list, next refresh after 2025-05-08 08:52:02.533527225 +0000 UTC m=+207.325598244
I0508 08:51:02.533906       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:51:02.534117       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1a/i-0a1187c6328e439e1
I0508 08:51:02.534148       1 static_autoscaler.go:407] 1 unregistered nodes present
W0508 08:51:02.534159       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1a/i-0a1187c6328e439e1, skipping
I0508 08:51:02.534182       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:51:02.534191       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:51:02.534201       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:51:02.534206       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:51:02.534210       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:51:02.534231       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:51:02.534249       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:51:02.534262       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:51:02.534297       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:51:02.534327       1 static_autoscaler.go:649] Starting scale down
I0508 08:51:02.534347       1 legacy.go:296] No candidates for scale down
I0508 08:51:12.546366       1 static_autoscaler.go:289] Starting main loop
I0508 08:51:12.546716       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:51:12.546922       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1a/i-0a1187c6328e439e1
I0508 08:51:12.546960       1 static_autoscaler.go:407] 1 unregistered nodes present
W0508 08:51:12.546987       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1a/i-0a1187c6328e439e1, skipping
I0508 08:51:12.547012       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:51:12.547020       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:51:12.547027       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:51:12.547031       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:51:12.547034       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:51:12.547049       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:51:12.547061       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:51:12.547070       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:51:12.547099       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:51:12.547124       1 static_autoscaler.go:649] Starting scale down
I0508 08:51:12.547139       1 legacy.go:296] No candidates for scale down
I0508 08:51:22.561408       1 static_autoscaler.go:289] Starting main loop
I0508 08:51:22.561766       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:51:22.561965       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1a/i-0a1187c6328e439e1
I0508 08:51:22.562006       1 static_autoscaler.go:407] 1 unregistered nodes present
W0508 08:51:22.562023       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1a/i-0a1187c6328e439e1, skipping
I0508 08:51:22.562046       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:51:22.562055       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:51:22.562065       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:51:22.562069       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:51:22.562072       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:51:22.562086       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:51:22.562103       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:51:22.562116       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:51:22.562139       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:51:22.562164       1 static_autoscaler.go:649] Starting scale down
I0508 08:51:22.562183       1 legacy.go:296] No candidates for scale down
I0508 08:51:32.575034       1 static_autoscaler.go:289] Starting main loop
I0508 08:51:32.575357       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:51:32.575515       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1a/i-0a1187c6328e439e1
I0508 08:51:32.575554       1 static_autoscaler.go:407] 1 unregistered nodes present
W0508 08:51:32.575570       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1a/i-0a1187c6328e439e1, skipping
I0508 08:51:32.575592       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:51:32.575605       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:51:32.575619       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:51:32.575624       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:51:32.575630       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:51:32.575651       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:51:32.575671       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:51:32.575687       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:51:32.575724       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:51:32.575756       1 static_autoscaler.go:649] Starting scale down
I0508 08:51:32.575781       1 legacy.go:296] No candidates for scale down
I0508 08:51:42.590015       1 static_autoscaler.go:289] Starting main loop
I0508 08:51:42.590454       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:51:42.590639       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1a/i-0a1187c6328e439e1
I0508 08:51:42.590676       1 static_autoscaler.go:407] 1 unregistered nodes present
W0508 08:51:42.590691       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1a/i-0a1187c6328e439e1, skipping
I0508 08:51:42.590716       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:51:42.590731       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:51:42.590746       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:51:42.590755       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:51:42.590761       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:51:42.590791       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:51:42.590812       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:51:42.590829       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:51:42.590865       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:51:42.590899       1 static_autoscaler.go:649] Starting scale down
I0508 08:51:42.590922       1 legacy.go:296] No candidates for scale down
I0508 08:51:52.603762       1 static_autoscaler.go:289] Starting main loop
I0508 08:51:52.604125       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:51:52.604313       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1a/i-0a1187c6328e439e1
I0508 08:51:52.604354       1 static_autoscaler.go:407] 1 unregistered nodes present
W0508 08:51:52.604370       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1a/i-0a1187c6328e439e1, skipping
I0508 08:51:52.604393       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:51:52.604403       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:51:52.604412       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:51:52.604416       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:51:52.604419       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:51:52.604434       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:51:52.604447       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:51:52.604460       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:51:52.604487       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:51:52.604510       1 static_autoscaler.go:649] Starting scale down
I0508 08:51:52.604527       1 legacy.go:296] No candidates for scale down
I0508 08:52:02.621172       1 static_autoscaler.go:289] Starting main loop
I0508 08:52:02.621356       1 auto_scaling_groups.go:369] Regenerating instance to ASG map for ASG names: []
I0508 08:52:02.621390       1 auto_scaling_groups.go:376] Regenerating instance to ASG map for ASG tags: map[k8s.io/cluster-autoscaler/enabled: k8s.io/cluster-autoscaler/my-cluster:]
I0508 08:52:02.732452       1 aws_wrapper.go:703] 0 launch configurations to query
I0508 08:52:02.732467       1 aws_wrapper.go:704] 0 launch templates to query
I0508 08:52:02.732474       1 aws_wrapper.go:724] Successfully queried 0 launch configurations
I0508 08:52:02.732481       1 aws_wrapper.go:735] Successfully queried 0 launch templates
I0508 08:52:02.732488       1 aws_wrapper.go:746] Successfully queried instance requirements for 0 ASGs
I0508 08:52:02.732498       1 aws_manager.go:132] Refreshed ASG list, next refresh after 2025-05-08 08:53:02.732495573 +0000 UTC m=+267.524566591
I0508 08:52:02.732827       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:52:02.732995       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1a/i-0a1187c6328e439e1
I0508 08:52:02.733034       1 static_autoscaler.go:407] 1 unregistered nodes present
W0508 08:52:02.733049       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1a/i-0a1187c6328e439e1, skipping
I0508 08:52:02.733074       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:52:02.733085       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:52:02.733098       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:52:02.733104       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:52:02.733110       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:52:02.733136       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:52:02.733159       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:52:02.733179       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:52:02.733215       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:52:02.733250       1 static_autoscaler.go:649] Starting scale down
I0508 08:52:02.733275       1 legacy.go:296] No candidates for scale down
I0508 08:52:12.750393       1 static_autoscaler.go:289] Starting main loop
I0508 08:52:12.750721       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:52:12.750876       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1a/i-0a1187c6328e439e1
I0508 08:52:12.750914       1 static_autoscaler.go:407] 1 unregistered nodes present
W0508 08:52:12.750932       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1a/i-0a1187c6328e439e1, skipping
I0508 08:52:12.750954       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:52:12.750967       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:52:12.750995       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:52:12.751002       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:52:12.751007       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:52:12.751028       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:52:12.751049       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:52:12.751065       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:52:12.751098       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:52:12.751130       1 static_autoscaler.go:649] Starting scale down
I0508 08:52:12.751154       1 legacy.go:296] No candidates for scale down
I0508 08:52:22.766029       1 static_autoscaler.go:289] Starting main loop
I0508 08:52:22.766409       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:52:22.766596       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1a/i-0a1187c6328e439e1
I0508 08:52:22.766642       1 static_autoscaler.go:407] 1 unregistered nodes present
W0508 08:52:22.766659       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1a/i-0a1187c6328e439e1, skipping
I0508 08:52:22.766680       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:52:22.766687       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:52:22.766698       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:52:22.766703       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:52:22.766709       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:52:22.766733       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:52:22.766745       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:52:22.766755       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:52:22.766779       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:52:22.766809       1 static_autoscaler.go:649] Starting scale down
I0508 08:52:22.766823       1 legacy.go:296] No candidates for scale down
I0508 08:52:32.781290       1 static_autoscaler.go:289] Starting main loop
I0508 08:52:32.781658       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:52:32.781851       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1a/i-0a1187c6328e439e1
I0508 08:52:32.781892       1 static_autoscaler.go:407] 1 unregistered nodes present
W0508 08:52:32.781909       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1a/i-0a1187c6328e439e1, skipping
I0508 08:52:32.781931       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:52:32.781939       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:52:32.781946       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:52:32.781950       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:52:32.781953       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:52:32.781968       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:52:32.781982       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:52:32.781996       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:52:32.782019       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:52:32.782044       1 static_autoscaler.go:649] Starting scale down
I0508 08:52:32.782058       1 legacy.go:296] No candidates for scale down
I0508 08:52:42.796125       1 static_autoscaler.go:289] Starting main loop
I0508 08:52:42.796461       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:52:42.796621       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1a/i-0a1187c6328e439e1
I0508 08:52:42.796659       1 static_autoscaler.go:407] 1 unregistered nodes present
W0508 08:52:42.796677       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1a/i-0a1187c6328e439e1, skipping
I0508 08:52:42.796699       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:52:42.796711       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:52:42.796724       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:52:42.796730       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:52:42.796735       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:52:42.796756       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:52:42.796776       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:52:42.796792       1 pre_filtering_processor.go:67] Skipping ip-192-168-72-73.eu-central-1.compute.internal - node group min size reached (current: 1, min: 1)
I0508 08:52:42.796826       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=false
I0508 08:52:42.796858       1 static_autoscaler.go:649] Starting scale down
I0508 08:52:42.796884       1 legacy.go:296] No candidates for scale down
I0508 08:52:52.810464       1 static_autoscaler.go:289] Starting main loop
I0508 08:52:52.810816       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
W0508 08:52:52.811005       1 clusterstate.go:604] Nodegroup is nil for aws:///eu-central-1a/i-0a1187c6328e439e1
I0508 08:52:52.811044       1 static_autoscaler.go:407] 1 unregistered nodes present
W0508 08:52:52.811061       1 static_autoscaler.go:741] No node group for node aws:///eu-central-1a/i-0a1187c6328e439e1, skipping
I0508 08:52:52.811096       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:52:52.811165       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-4mcjs: cannot put pod nginx-55f598f8d-4mcjs on any node
I0508 08:52:52.811219       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-c2hd7 based on similar pods scheduling
I0508 08:52:52.811248       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-kbks8 based on similar pods scheduling
I0508 08:52:52.811272       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-w27bk based on similar pods scheduling
I0508 08:52:52.811294       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-hj92h based on similar pods scheduling
I0508 08:52:52.811322       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-568fd based on similar pods scheduling
I0508 08:52:52.811343       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-rtxs8 based on similar pods scheduling
I0508 08:52:52.811366       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-rjcfs based on similar pods scheduling
I0508 08:52:52.811395       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-flk7t based on similar pods scheduling
I0508 08:52:52.811416       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-wk5gt based on similar pods scheduling
I0508 08:52:52.811437       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-z946h based on similar pods scheduling
I0508 08:52:52.811459       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-vqp5q based on similar pods scheduling
I0508 08:52:52.811485       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-x8vp7 based on similar pods scheduling
I0508 08:52:52.811507       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-dbgfm based on similar pods scheduling
I0508 08:52:52.811528       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-dw9px based on similar pods scheduling
I0508 08:52:52.811556       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-ltb42 based on similar pods scheduling
I0508 08:52:52.811564       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:52:52.811571       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:52:52.811575       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:52:52.811580       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 16 unschedulable pods left
I0508 08:52:52.811595       1 klogx.go:87] Pod default/nginx-55f598f8d-4mcjs is unschedulable
I0508 08:52:52.811600       1 klogx.go:87] Pod default/nginx-55f598f8d-c2hd7 is unschedulable
I0508 08:52:52.811604       1 klogx.go:87] Pod default/nginx-55f598f8d-kbks8 is unschedulable
I0508 08:52:52.811608       1 klogx.go:87] Pod default/nginx-55f598f8d-w27bk is unschedulable
I0508 08:52:52.811611       1 klogx.go:87] Pod default/nginx-55f598f8d-hj92h is unschedulable
I0508 08:52:52.811616       1 klogx.go:87] Pod default/nginx-55f598f8d-568fd is unschedulable
I0508 08:52:52.811623       1 klogx.go:87] Pod default/nginx-55f598f8d-rtxs8 is unschedulable
I0508 08:52:52.811629       1 klogx.go:87] Pod default/nginx-55f598f8d-rjcfs is unschedulable
I0508 08:52:52.811634       1 klogx.go:87] Pod default/nginx-55f598f8d-flk7t is unschedulable
I0508 08:52:52.811638       1 klogx.go:87] Pod default/nginx-55f598f8d-wk5gt is unschedulable
I0508 08:52:52.811641       1 klogx.go:87] Pod default/nginx-55f598f8d-z946h is unschedulable
I0508 08:52:52.811645       1 klogx.go:87] Pod default/nginx-55f598f8d-vqp5q is unschedulable
I0508 08:52:52.811649       1 klogx.go:87] Pod default/nginx-55f598f8d-x8vp7 is unschedulable
I0508 08:52:52.811652       1 klogx.go:87] Pod default/nginx-55f598f8d-dbgfm is unschedulable
I0508 08:52:52.811657       1 klogx.go:87] Pod default/nginx-55f598f8d-dw9px is unschedulable
I0508 08:52:52.811660       1 klogx.go:87] Pod default/nginx-55f598f8d-ltb42 is unschedulable
I0508 08:52:52.811927       1 orchestrator.go:109] Upcoming 0 nodes
I0508 08:52:52.812246       1 waste.go:55] Expanding Node Group eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 would waste 100.00% CPU, 100.00% Memory, 100.00% Blended
I0508 08:52:52.812264       1 orchestrator.go:193] Best option to resize: eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788
I0508 08:52:52.812273       1 orchestrator.go:197] Estimated 1 nodes needed in eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788
I0508 08:52:52.812290       1 orchestrator.go:310] Final scale-up plan: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:52.812302       1 orchestrator.go:582] Scale-up: setting group eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 size to 2
I0508 08:52:52.812334       1 auto_scaling_groups.go:257] Setting asg eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 size to 2
I0508 08:52:52.812456       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"ConfigMap", Namespace:"kube-system", Name:"cluster-autoscaler-status", UID:"9bfbb9cb-3bb7-42be-ae46-23fb45cec6e1", APIVersion:"v1", ResourceVersion:"16852", FieldPath:""}): type: 'Normal' reason: 'ScaledUpGroup' Scale-up: setting group eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 size to 2 instead of 1 (max: 3)
I0508 08:52:52.935525       1 eventing_scale_up_processor.go:47] Skipping event processing for unschedulable pods since there is a ScaleUp attempt this loop
I0508 08:52:52.935527       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"ConfigMap", Namespace:"kube-system", Name:"cluster-autoscaler-status", UID:"9bfbb9cb-3bb7-42be-ae46-23fb45cec6e1", APIVersion:"v1", ResourceVersion:"16852", FieldPath:""}): type: 'Normal' reason: 'ScaledUpGroup' Scale-up: group eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 size set to 2 instead of 1 (max: 3)
I0508 08:52:52.944077       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-4mcjs", UID:"14936dbf-cbc0-405a-9fd2-25bee5f2ce62", APIVersion:"v1", ResourceVersion:"16899", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:52.951335       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-c2hd7", UID:"c8bb70c2-e043-4d92-81f7-2d9fe4b160f5", APIVersion:"v1", ResourceVersion:"16912", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:52.959619       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-kbks8", UID:"752b1346-7218-47bd-a977-fb66e4636248", APIVersion:"v1", ResourceVersion:"16930", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:52.966594       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-w27bk", UID:"511751c5-b15a-473d-a843-7e7bacc15855", APIVersion:"v1", ResourceVersion:"16909", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:52.972764       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-hj92h", UID:"75d28456-b18f-4a56-880c-add9291742c4", APIVersion:"v1", ResourceVersion:"16941", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:52.978656       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-568fd", UID:"6a541037-0dea-48b7-9eb3-0ec8fd6fa7f5", APIVersion:"v1", ResourceVersion:"16939", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:52.987573       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-rtxs8", UID:"29196e42-d47c-48d0-b382-c9e86f994921", APIVersion:"v1", ResourceVersion:"16943", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:52.994681       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-rjcfs", UID:"8b27f6a4-0f2f-4008-bfd9-fa9e3688c70a", APIVersion:"v1", ResourceVersion:"16894", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:53.000017       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-flk7t", UID:"b5546e27-0c82-45b6-8e34-64f973412172", APIVersion:"v1", ResourceVersion:"16926", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:53.020381       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-wk5gt", UID:"4f8b1fd7-01d4-44c1-812d-6d442f96d375", APIVersion:"v1", ResourceVersion:"16933", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:53.213648       1 request.go:628] Waited for 193.195364ms due to client-side throttling, not priority and fairness, request: POST:https://10.100.0.1:443/api/v1/namespaces/default/events
I0508 08:52:53.220311       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-z946h", UID:"e1f33faa-4865-497e-a045-6847b9e439c0", APIVersion:"v1", ResourceVersion:"16936", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:53.412659       1 request.go:628] Waited for 192.245035ms due to client-side throttling, not priority and fairness, request: POST:https://10.100.0.1:443/api/v1/namespaces/default/events
I0508 08:52:53.418891       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-vqp5q", UID:"73b69e7d-e852-422e-845e-ed00b72921dc", APIVersion:"v1", ResourceVersion:"16937", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:53.613270       1 request.go:628] Waited for 194.294081ms due to client-side throttling, not priority and fairness, request: POST:https://10.100.0.1:443/api/v1/namespaces/default/events
I0508 08:52:53.622180       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-x8vp7", UID:"7dee1bc0-3c19-47a2-aacd-312ac9d1d2a8", APIVersion:"v1", ResourceVersion:"16896", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:53.813567       1 request.go:628] Waited for 191.304691ms due to client-side throttling, not priority and fairness, request: POST:https://10.100.0.1:443/api/v1/namespaces/default/events
I0508 08:52:53.821065       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-dbgfm", UID:"e8a7c3fc-5c5e-41fc-8a2b-211107486567", APIVersion:"v1", ResourceVersion:"16919", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:54.013457       1 request.go:628] Waited for 192.310222ms due to client-side throttling, not priority and fairness, request: POST:https://10.100.0.1:443/api/v1/namespaces/default/events
I0508 08:52:54.023011       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-dw9px", UID:"ddddb68c-5019-4692-82aa-f42b9208f058", APIVersion:"v1", ResourceVersion:"16921", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:54.213266       1 request.go:628] Waited for 190.155013ms due to client-side throttling, not priority and fairness, request: POST:https://10.100.0.1:443/api/v1/namespaces/default/events
I0508 08:52:54.219630       1 event_sink_logging_wrapper.go:48] Event(v1.ObjectReference{Kind:"Pod", Namespace:"default", Name:"nginx-55f598f8d-ltb42", UID:"2a933612-9d16-435b-8498-101bac03a939", APIVersion:"v1", ResourceVersion:"16924", FieldPath:""}): type: 'Normal' reason: 'TriggeredScaleUp' pod triggered scale-up: [{eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 1->2 (max: 3)}]
I0508 08:52:54.413193       1 request.go:628] Waited for 193.481698ms due to client-side throttling, not priority and fairness, request: POST:https://10.100.0.1:443/api/v1/namespaces/default/events
I0508 08:53:01.988369       1 node_instances_cache.go:156] Start refreshing cloud provider node instances cache
I0508 08:53:01.988406       1 node_instances_cache.go:168] Refresh cloud provider node instances cache finished, refresh took 10.282µs
I0508 08:53:02.950897       1 static_autoscaler.go:289] Starting main loop
I0508 08:53:02.950967       1 auto_scaling_groups.go:369] Regenerating instance to ASG map for ASG names: []
I0508 08:53:02.950981       1 auto_scaling_groups.go:376] Regenerating instance to ASG map for ASG tags: map[k8s.io/cluster-autoscaler/enabled: k8s.io/cluster-autoscaler/my-cluster:]
I0508 08:53:03.064961       1 auto_scaling_groups.go:142] Updating ASG eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788
I0508 08:53:03.064991       1 aws_wrapper.go:703] 0 launch configurations to query
I0508 08:53:03.064998       1 aws_wrapper.go:704] 0 launch templates to query
I0508 08:53:03.065018       1 aws_wrapper.go:724] Successfully queried 0 launch configurations
I0508 08:53:03.065024       1 aws_wrapper.go:735] Successfully queried 0 launch templates
I0508 08:53:03.065031       1 aws_wrapper.go:746] Successfully queried instance requirements for 0 ASGs
I0508 08:53:03.065041       1 aws_manager.go:132] Refreshed ASG list, next refresh after 2025-05-08 08:54:03.065037218 +0000 UTC m=+327.857108242
I0508 08:53:03.065545       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:53:03.065863       1 static_autoscaler.go:407] 1 unregistered nodes present
I0508 08:53:03.066074       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:53:03.066153       1 klogx.go:87] Pod default/nginx-55f598f8d-x8vp7 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066187       1 klogx.go:87] Pod default/nginx-55f598f8d-dbgfm can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066232       1 klogx.go:87] Pod default/nginx-55f598f8d-dw9px can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066260       1 klogx.go:87] Pod default/nginx-55f598f8d-ltb42 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066302       1 klogx.go:87] Pod default/nginx-55f598f8d-4mcjs can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066331       1 klogx.go:87] Pod default/nginx-55f598f8d-c2hd7 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066370       1 klogx.go:87] Pod default/nginx-55f598f8d-kbks8 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066398       1 klogx.go:87] Pod default/nginx-55f598f8d-w27bk can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066440       1 klogx.go:87] Pod default/nginx-55f598f8d-hj92h can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066469       1 klogx.go:87] Pod default/nginx-55f598f8d-vqp5q can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066509       1 klogx.go:87] Pod default/nginx-55f598f8d-568fd can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066535       1 klogx.go:87] Pod default/nginx-55f598f8d-rtxs8 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066564       1 klogx.go:87] Pod default/nginx-55f598f8d-rjcfs can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066606       1 klogx.go:87] Pod default/nginx-55f598f8d-flk7t can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066635       1 klogx.go:87] Pod default/nginx-55f598f8d-wk5gt can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066676       1 klogx.go:87] Pod default/nginx-55f598f8d-z946h can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2606258838189952279-upcoming-0
I0508 08:53:03.066689       1 filter_out_schedulable.go:120] 16 pods marked as unschedulable can be scheduled.
I0508 08:53:03.066701       1 filter_out_schedulable.go:75] Schedulable pods present
I0508 08:53:03.066707       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:53:03.066713       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:53:03.066751       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:53:03.066770       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:53:03.066825       1 klogx.go:87] Node ip-192-168-72-73.eu-central-1.compute.internal - cpu utilization 0.233161
I0508 08:53:03.066866       1 legacy.go:166] Finding additional 1 candidates for scale down.
I0508 08:53:03.066874       1 cluster.go:155] ip-192-168-72-73.eu-central-1.compute.internal for removal
I0508 08:53:03.066916       1 cluster.go:164] node ip-192-168-72-73.eu-central-1.compute.internal cannot be removed: pod annotated as not safe to evict present: cluster-autoscaler-6768dd59d5-hfffq
I0508 08:53:03.066929       1 legacy.go:193] 1 nodes found to be unremovable in simulation, will re-check them at 2025-05-08 08:58:02.950868024 +0000 UTC m=+567.742939159
I0508 08:53:03.066973       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:53:13.086773       1 static_autoscaler.go:289] Starting main loop
I0508 08:53:13.087162       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:53:13.087387       1 static_autoscaler.go:407] 1 unregistered nodes present
I0508 08:53:13.087516       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:53:13.087591       1 klogx.go:87] Pod default/nginx-55f598f8d-ltb42 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.087632       1 klogx.go:87] Pod default/nginx-55f598f8d-x8vp7 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.087671       1 klogx.go:87] Pod default/nginx-55f598f8d-dbgfm can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.087710       1 klogx.go:87] Pod default/nginx-55f598f8d-dw9px can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.087744       1 klogx.go:87] Pod default/nginx-55f598f8d-4mcjs can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.087786       1 klogx.go:87] Pod default/nginx-55f598f8d-c2hd7 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.087821       1 klogx.go:87] Pod default/nginx-55f598f8d-kbks8 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.087855       1 klogx.go:87] Pod default/nginx-55f598f8d-w27bk can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.087894       1 klogx.go:87] Pod default/nginx-55f598f8d-hj92h can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.087928       1 klogx.go:87] Pod default/nginx-55f598f8d-z946h can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.087960       1 klogx.go:87] Pod default/nginx-55f598f8d-vqp5q can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.087991       1 klogx.go:87] Pod default/nginx-55f598f8d-568fd can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.088027       1 klogx.go:87] Pod default/nginx-55f598f8d-rtxs8 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.088059       1 klogx.go:87] Pod default/nginx-55f598f8d-rjcfs can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.088093       1 klogx.go:87] Pod default/nginx-55f598f8d-flk7t can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.088129       1 klogx.go:87] Pod default/nginx-55f598f8d-wk5gt can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-2333583170008653194-upcoming-0
I0508 08:53:13.088147       1 filter_out_schedulable.go:120] 16 pods marked as unschedulable can be scheduled.
I0508 08:53:13.088163       1 filter_out_schedulable.go:75] Schedulable pods present
I0508 08:53:13.088170       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:53:13.088176       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:53:13.088202       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:53:13.088222       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:53:13.088249       1 eligibility.go:102] Scale-down calculation: ignoring 1 nodes unremovable in the last 5m0s
I0508 08:53:13.088286       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:53:23.103576       1 static_autoscaler.go:289] Starting main loop
I0508 08:53:23.103968       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:53:23.104203       1 static_autoscaler.go:407] 1 unregistered nodes present
I0508 08:53:23.104354       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:53:23.104435       1 klogx.go:87] Pod default/nginx-55f598f8d-w27bk can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104475       1 klogx.go:87] Pod default/nginx-55f598f8d-hj92h can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104507       1 klogx.go:87] Pod default/nginx-55f598f8d-wk5gt can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104541       1 klogx.go:87] Pod default/nginx-55f598f8d-z946h can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104573       1 klogx.go:87] Pod default/nginx-55f598f8d-vqp5q can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104610       1 klogx.go:87] Pod default/nginx-55f598f8d-568fd can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104643       1 klogx.go:87] Pod default/nginx-55f598f8d-rtxs8 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104675       1 klogx.go:87] Pod default/nginx-55f598f8d-rjcfs can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104708       1 klogx.go:87] Pod default/nginx-55f598f8d-flk7t can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104742       1 klogx.go:87] Pod default/nginx-55f598f8d-dw9px can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104777       1 klogx.go:87] Pod default/nginx-55f598f8d-ltb42 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104809       1 klogx.go:87] Pod default/nginx-55f598f8d-x8vp7 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104841       1 klogx.go:87] Pod default/nginx-55f598f8d-dbgfm can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104875       1 klogx.go:87] Pod default/nginx-55f598f8d-kbks8 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104910       1 klogx.go:87] Pod default/nginx-55f598f8d-4mcjs can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104946       1 klogx.go:87] Pod default/nginx-55f598f8d-c2hd7 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-3233338539567257085-upcoming-0
I0508 08:53:23.104964       1 filter_out_schedulable.go:120] 16 pods marked as unschedulable can be scheduled.
I0508 08:53:23.104978       1 filter_out_schedulable.go:75] Schedulable pods present
I0508 08:53:23.104987       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:53:23.104994       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:53:23.105020       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:53:23.105039       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:53:23.105064       1 eligibility.go:102] Scale-down calculation: ignoring 1 nodes unremovable in the last 5m0s
I0508 08:53:23.105102       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:53:33.120049       1 static_autoscaler.go:289] Starting main loop
I0508 08:53:33.120376       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:53:33.120660       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:53:33.120727       1 klogx.go:87] Pod default/nginx-55f598f8d-x8vp7 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.120761       1 klogx.go:87] Pod default/nginx-55f598f8d-dbgfm can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.120784       1 klogx.go:87] Pod default/nginx-55f598f8d-dw9px can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.120805       1 klogx.go:87] Pod default/nginx-55f598f8d-ltb42 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.120832       1 klogx.go:87] Pod default/nginx-55f598f8d-4mcjs can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.120853       1 klogx.go:87] Pod default/nginx-55f598f8d-c2hd7 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.120872       1 klogx.go:87] Pod default/nginx-55f598f8d-kbks8 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.120890       1 klogx.go:87] Pod default/nginx-55f598f8d-w27bk can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.120915       1 klogx.go:87] Pod default/nginx-55f598f8d-hj92h can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.120932       1 klogx.go:87] Pod default/nginx-55f598f8d-568fd can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.120949       1 klogx.go:87] Pod default/nginx-55f598f8d-rtxs8 can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.120966       1 klogx.go:87] Pod default/nginx-55f598f8d-rjcfs can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.120990       1 klogx.go:87] Pod default/nginx-55f598f8d-flk7t can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.121008       1 klogx.go:87] Pod default/nginx-55f598f8d-wk5gt can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.121024       1 klogx.go:87] Pod default/nginx-55f598f8d-z946h can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.121040       1 klogx.go:87] Pod default/nginx-55f598f8d-vqp5q can be moved to template-node-for-eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788-7963849141211321213-upcoming-0
I0508 08:53:33.121049       1 filter_out_schedulable.go:120] 16 pods marked as unschedulable can be scheduled.
I0508 08:53:33.121060       1 filter_out_schedulable.go:75] Schedulable pods present
I0508 08:53:33.121067       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:53:33.121071       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:53:33.121087       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:53:33.121098       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:53:33.121115       1 eligibility.go:102] Scale-down calculation: ignoring 1 nodes unremovable in the last 5m0s
I0508 08:53:33.121141       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:53:43.134500       1 static_autoscaler.go:289] Starting main loop
I0508 08:53:43.134933       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:53:43.135153       1 clusterstate.go:258] Scale up in group eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788 finished successfully in 50.199055563s
I0508 08:53:43.135202       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:53:43.135214       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:53:43.135225       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:53:43.135231       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:53:43.135236       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:53:43.135255       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:53:43.135274       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:53:43.135306       1 klogx.go:87] Node ip-192-168-16-40.eu-central-1.compute.internal - cpu utilization 0.077720
I0508 08:53:43.135316       1 eligibility.go:102] Scale-down calculation: ignoring 1 nodes unremovable in the last 5m0s
I0508 08:53:43.135346       1 legacy.go:166] Finding additional 1 candidates for scale down.
I0508 08:53:43.135353       1 cluster.go:155] ip-192-168-16-40.eu-central-1.compute.internal for removal
I0508 08:53:43.135444       1 klogx.go:87] failed to find place for default/nginx-55f598f8d-568fd: cannot put pod nginx-55f598f8d-568fd on any node
I0508 08:53:43.135452       1 cluster.go:175] node ip-192-168-16-40.eu-central-1.compute.internal is not suitable for removal: can reschedule only 0 out of 16 pods
I0508 08:53:43.135459       1 legacy.go:193] 1 nodes found to be unremovable in simulation, will re-check them at 2025-05-08 08:58:43.134459119 +0000 UTC m=+607.926530191
I0508 08:53:43.135480       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:53:53.148999       1 static_autoscaler.go:289] Starting main loop
I0508 08:53:53.149414       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:53:53.149615       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:53:53.149632       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:53:53.149644       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:53:53.149652       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:53:53.149658       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:53:53.149683       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:53:53.149705       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:53:53.149729       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:53:53.149759       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:54:03.162927       1 static_autoscaler.go:289] Starting main loop
I0508 08:54:03.163006       1 auto_scaling_groups.go:369] Regenerating instance to ASG map for ASG names: []
I0508 08:54:03.163020       1 auto_scaling_groups.go:376] Regenerating instance to ASG map for ASG tags: map[k8s.io/cluster-autoscaler/enabled: k8s.io/cluster-autoscaler/my-cluster:]
I0508 08:54:03.259860       1 auto_scaling_groups.go:142] Updating ASG eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788
I0508 08:54:03.259890       1 aws_wrapper.go:703] 0 launch configurations to query
I0508 08:54:03.259896       1 aws_wrapper.go:704] 0 launch templates to query
I0508 08:54:03.259903       1 aws_wrapper.go:724] Successfully queried 0 launch configurations
I0508 08:54:03.259917       1 aws_wrapper.go:735] Successfully queried 0 launch templates
I0508 08:54:03.259926       1 aws_wrapper.go:746] Successfully queried instance requirements for 0 ASGs
I0508 08:54:03.259937       1 aws_manager.go:132] Refreshed ASG list, next refresh after 2025-05-08 08:55:03.259932979 +0000 UTC m=+388.052003999
I0508 08:54:03.260816       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:54:03.261064       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:54:03.261377       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:54:03.261399       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:54:03.261405       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:54:03.261410       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:54:03.261436       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:54:03.261472       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:54:03.261512       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:54:03.261566       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:54:13.276739       1 static_autoscaler.go:289] Starting main loop
I0508 08:54:13.277609       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:54:13.278029       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:54:13.278042       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:54:13.278053       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:54:13.278058       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:54:13.278063       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:54:13.278097       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:54:13.278115       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:54:13.278138       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:54:13.278176       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:54:23.307060       1 static_autoscaler.go:289] Starting main loop
I0508 08:54:23.307462       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:54:23.307654       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:54:23.307668       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:54:23.307676       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:54:23.307680       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:54:23.307683       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:54:23.307699       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:54:23.307711       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:54:23.307726       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:54:23.307754       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:54:33.322149       1 static_autoscaler.go:289] Starting main loop
I0508 08:54:33.322649       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:54:33.322891       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:54:33.322904       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:54:33.322914       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:54:33.322919       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:54:33.322924       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:54:33.322949       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:54:33.322968       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:54:33.322999       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:54:33.323036       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:54:43.334004       1 static_autoscaler.go:289] Starting main loop
I0508 08:54:43.334563       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:54:43.334838       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:54:43.334869       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:54:43.334880       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:54:43.334887       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:54:43.334891       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:54:43.334913       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:54:43.334929       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:54:43.334952       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:54:43.334998       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:54:45.897104       1 reflector.go:788] k8s.io/client-go/informers/factory.go:150: Watch close - *v1.StorageClass total 7 items received
I0508 08:54:48.238091       1 reflector.go:788] k8s.io/client-go/informers/factory.go:150: Watch close - *v1.Service total 6 items received
I0508 08:54:53.348601       1 static_autoscaler.go:289] Starting main loop
I0508 08:54:53.348949       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:54:53.349149       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:54:53.349163       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:54:53.349174       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:54:53.349182       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:54:53.349188       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:54:53.349210       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:54:53.349233       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:54:53.349255       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:54:53.349285       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:55:01.988533       1 node_instances_cache.go:156] Start refreshing cloud provider node instances cache
I0508 08:55:01.988565       1 node_instances_cache.go:168] Refresh cloud provider node instances cache finished, refresh took 10.977µs
I0508 08:55:03.363161       1 static_autoscaler.go:289] Starting main loop
I0508 08:55:03.363223       1 auto_scaling_groups.go:369] Regenerating instance to ASG map for ASG names: []
I0508 08:55:03.363237       1 auto_scaling_groups.go:376] Regenerating instance to ASG map for ASG tags: map[k8s.io/cluster-autoscaler/enabled: k8s.io/cluster-autoscaler/my-cluster:]
I0508 08:55:03.459479       1 auto_scaling_groups.go:142] Updating ASG eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788
I0508 08:55:03.459508       1 aws_wrapper.go:703] 0 launch configurations to query
I0508 08:55:03.459515       1 aws_wrapper.go:704] 0 launch templates to query
I0508 08:55:03.459522       1 aws_wrapper.go:724] Successfully queried 0 launch configurations
I0508 08:55:03.459528       1 aws_wrapper.go:735] Successfully queried 0 launch templates
I0508 08:55:03.459535       1 aws_wrapper.go:746] Successfully queried instance requirements for 0 ASGs
I0508 08:55:03.459545       1 aws_manager.go:132] Refreshed ASG list, next refresh after 2025-05-08 08:56:03.459541106 +0000 UTC m=+448.251612124
I0508 08:55:03.459949       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:55:03.460160       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:55:03.460175       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:55:03.460185       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:55:03.460191       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:55:03.460195       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:55:03.460221       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:55:03.460242       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:55:03.460268       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:55:03.460309       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:55:13.472900       1 static_autoscaler.go:289] Starting main loop
I0508 08:55:13.473233       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
E0508 08:55:13.556158       1 managed_nodegroup_cache.go:136] Failed to query the managed nodegroup ng-cc1c9586 for the cluster my-cluster while looking for labels/taints/tags: AccessDeniedException: User: arn:aws:sts::524196012679:assumed-role/EKSAutoScalerRole/1746694137844533326 is not authorized to perform: eks:DescribeNodegroup on resource: arn:aws:eks:eu-central-1:524196012679:nodegroup/my-cluster/ng-cc1c9586/e0cb5767-5310-8285-c96d-77388791a788
E0508 08:55:13.556185       1 aws_manager.go:299] Failed to get labels from EKS DescribeNodegroup API for nodegroup ng-cc1c9586 in cluster my-cluster because AccessDeniedException: User: arn:aws:sts::524196012679:assumed-role/EKSAutoScalerRole/1746694137844533326 is not authorized to perform: eks:DescribeNodegroup on resource: arn:aws:eks:eu-central-1:524196012679:nodegroup/my-cluster/ng-cc1c9586/e0cb5767-5310-8285-c96d-77388791a788.
I0508 08:55:13.556332       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:55:13.556348       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:55:13.556359       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:55:13.556369       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:55:13.556374       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:55:13.556398       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:55:13.556420       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:55:13.556449       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:55:13.556487       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:55:16.240445       1 reflector.go:788] k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:338: Watch close - *v1.Job total 7 items received
I0508 08:55:16.897784       1 reflector.go:788] k8s.io/client-go/informers/factory.go:150: Watch close - *v1.CSINode total 11 items received
I0508 08:55:23.570600       1 static_autoscaler.go:289] Starting main loop
I0508 08:55:23.571160       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:55:23.572112       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:55:23.572129       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:55:23.572152       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:55:23.572176       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:55:23.572201       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:55:23.572478       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:55:23.572537       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:55:23.572596       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:55:23.572655       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:55:33.584868       1 static_autoscaler.go:289] Starting main loop
I0508 08:55:33.585218       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:55:33.585429       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:55:33.585445       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:55:33.585456       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:55:33.585465       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:55:33.585471       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:55:33.585498       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:55:33.585522       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:55:33.585547       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:55:33.585583       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:55:38.799190       1 reflector.go:788] k8s.io/client-go/informers/factory.go:150: Watch close - *v1.CSIDriver total 8 items received
I0508 08:55:43.598603       1 static_autoscaler.go:289] Starting main loop
I0508 08:55:43.599116       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:55:43.599377       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:55:43.599389       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:55:43.599399       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:55:43.599404       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:55:43.599409       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:55:43.599430       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:55:43.599447       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:55:43.599470       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:55:43.599501       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:55:44.997291       1 reflector.go:788] k8s.io/client-go/informers/factory.go:150: Watch close - *v1.Pod total 130 items received
I0508 08:55:45.837611       1 reflector.go:788] k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:320: Watch close - *v1.DaemonSet total 19 items received
I0508 08:55:52.438004       1 reflector.go:788] k8s.io/autoscaler/cluster-autoscaler/utils/kubernetes/listers.go:347: Watch close - *v1.ReplicaSet total 31 items received
I0508 08:55:53.615284       1 static_autoscaler.go:289] Starting main loop
I0508 08:55:53.615756       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:55:53.616008       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:55:53.616023       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:55:53.616034       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:55:53.616040       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:55:53.616046       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:55:53.616069       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:55:53.616088       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:55:53.616111       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:55:53.616144       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:55:59.799278       1 reflector.go:788] k8s.io/client-go/informers/factory.go:150: Watch close - *v1.Namespace total 8 items received
I0508 08:56:00.037096       1 reflector.go:788] k8s.io/client-go/informers/factory.go:150: Watch close - *v1.PodDisruptionBudget total 9 items received
I0508 08:56:03.629350       1 static_autoscaler.go:289] Starting main loop
I0508 08:56:03.629421       1 auto_scaling_groups.go:369] Regenerating instance to ASG map for ASG names: []
I0508 08:56:03.629437       1 auto_scaling_groups.go:376] Regenerating instance to ASG map for ASG tags: map[k8s.io/cluster-autoscaler/enabled: k8s.io/cluster-autoscaler/my-cluster:]
I0508 08:56:03.725766       1 auto_scaling_groups.go:142] Updating ASG eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788
I0508 08:56:03.725798       1 aws_wrapper.go:703] 0 launch configurations to query
I0508 08:56:03.725804       1 aws_wrapper.go:704] 0 launch templates to query
I0508 08:56:03.725810       1 aws_wrapper.go:724] Successfully queried 0 launch configurations
I0508 08:56:03.725816       1 aws_wrapper.go:735] Successfully queried 0 launch templates
I0508 08:56:03.725823       1 aws_wrapper.go:746] Successfully queried instance requirements for 0 ASGs
I0508 08:56:03.725834       1 aws_manager.go:132] Refreshed ASG list, next refresh after 2025-05-08 08:57:03.725830092 +0000 UTC m=+508.517901112
I0508 08:56:03.726240       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:56:03.726463       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:56:03.726477       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:56:03.726490       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:56:03.726495       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:56:03.726499       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:56:03.726522       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:56:03.726539       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:56:03.726560       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:56:03.726589       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:56:05.636905       1 reflector.go:788] k8s.io/client-go/informers/factory.go:150: Watch close - *v1.PersistentVolumeClaim total 8 items received
I0508 08:56:13.738211       1 static_autoscaler.go:289] Starting main loop
I0508 08:56:13.739068       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:56:13.739420       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:56:13.739437       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:56:13.739447       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:56:13.739454       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:56:13.739459       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:56:13.739484       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:56:13.739503       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:56:13.739526       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:56:13.739567       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:56:17.898946       1 reflector.go:788] k8s.io/client-go/informers/factory.go:150: Watch close - *v1.StatefulSet total 8 items received
I0508 08:56:23.794426       1 static_autoscaler.go:289] Starting main loop
I0508 08:56:23.794808       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:56:23.795022       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:56:23.795037       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:56:23.795048       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:56:23.795053       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:56:23.795057       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:56:23.795077       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:56:23.795094       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:56:23.795115       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:56:23.795146       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true
I0508 08:56:33.809366       1 static_autoscaler.go:289] Starting main loop
I0508 08:56:33.809745       1 aws_manager.go:188] Found multiple availability zones for ASG "eks-ng-cc1c9586-e0cb5767-5310-8285-c96d-77388791a788"; using eu-central-1a for failure-domain.beta.kubernetes.io/zone label
I0508 08:56:33.809925       1 filter_out_schedulable.go:63] Filtering out schedulables
I0508 08:56:33.809939       1 filter_out_schedulable.go:120] 0 pods marked as unschedulable can be scheduled.
I0508 08:56:33.809950       1 filter_out_schedulable.go:83] No schedulable pods
I0508 08:56:33.809955       1 filter_out_daemon_sets.go:40] Filtering out daemon set pods
I0508 08:56:33.809961       1 filter_out_daemon_sets.go:49] Filtered out 0 daemon set pods, 0 unschedulable pods left
I0508 08:56:33.809984       1 static_autoscaler.go:554] No unschedulable pods
I0508 08:56:33.810005       1 static_autoscaler.go:577] Calculating unneeded nodes
I0508 08:56:33.810030       1 eligibility.go:102] Scale-down calculation: ignoring 2 nodes unremovable in the last 5m0s
I0508 08:56:33.810058       1 static_autoscaler.go:624] Scale down status: lastScaleUpTime=2025-05-08 08:52:52.810441026 +0000 UTC m=+257.602512044 lastScaleDownDeleteTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 lastScaleDownFailTime=2025-05-08 07:49:01.987447748 +0000 UTC m=-3573.220481230 scaleDownForbidden=false scaleDownInCooldown=true


```

</details>

