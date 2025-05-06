# Create an ECR registry for your java-app image

# Locally, on your computer: Create a docker registry secret for ECR
DOCKER_REGISTRY_SERVER=your ECR registry server - "your-aws-id.dkr.ecr.your-ecr-region.amazonaws.com"
DOCKER_USER=your dockerID, same as for `docker login` - "AWS"
DOCKER_PASSWORD=your dockerhub pwd, same as for `docker login` - get using: "aws ecr get-login-password --region {ecr-region}"

kubectl create secret -n my-app docker-registry my-ecr-registry-key \
--docker-server=$DOCKER_REGISTRY_SERVER \
--docker-username=$DOCKER_USER \
--docker-password=$DOCKER_PASSWORD

# SSH into server where Jenkins container is running
ssh -i {private-key-path} {user}@{public-ip}

# Enter Jenkins container
sudo docker exec -it {jenkins-container-id} -u 0 bash

# Install aws-cli inside Jenkins container
- Link: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

# Install kubectl inside Jenkins container
- Link: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
chmod 644 /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl

# Install envsubst tool
- Link: https://command-not-found.com/envsubst

apt-get update
apt-get install -y gettext-base

# create 2 "secret-text" credentials for AWS access in Jenkins: 
- "jenkins_aws_access_key_id" for AWS_ACCESS_KEY_ID 
- "jenkins_aws_secret_access_key" for AWS_SECRET_ACCESS_KEY    

# Create 4 "secret-text" credentials for db-secret.yaml:
- id: "db_user", secret: "my-user"
- id: "db_pass", secret: "my-pass"
- id: "db_name", secret: "my-app-db"
- id: "db_root_pass", secret: "secret-root-pass"

# Set the correct values in Jenkins for following environment variables: 
- ECR_REPO_URL
- CLUSTER_REGION

# Create Jenkins pipeline using the Jenkinsfile in this branch, in the root folder
Make sure the paths to the k8s manifest files in the "deploy" stage of the Jenkinsfile are all correct!!
