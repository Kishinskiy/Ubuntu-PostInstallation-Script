#!/bin/bash
echo "update repository and install apt-https dependencies"
sudo apt-get update && \
sudo apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common && echo "apt-https dependensies installing";
echo "add GPG Key for Docker Repository"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && echo "GPG key added";
echo "add docker repository"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" && echo "docker repository added";
echo "install docker-CE"
sudo apt-get update && sudo apt-get -y install docker-ce docker-ce-cli containerd.io && echo "Docker installed";
echo "install docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose && echo "docker-compoe installed";
echo "add user for run docker commands"
sudo groupadd docker;
sudo usermod -aG docker $USER && echo "user for docker added";
echo "install minikube"
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube && \
sudo install minikube /usr/local/bin && echo "minikube installed"
echo "install kubectl"
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
chmod +x ./kubectl && \
sudo mv ./kubectl /usr/local/bin/kubectl && echo " kubectl installed"

echo "install helm"
curl -Lo helm.tar.gz https://get.helm.sh/helm-v2.14.2-linux-amd64.tar.gz && \
tar -zxvf helm.tar.gz && \
sudo mv linux-amd64/helm /usr/local/bin/helm && echo "helm installed"
echo  "install terraform" 
sudo apt update && sudo apt -y install unzip && \
curl -Lo terraform.zip https://releases.hashicorp.com/terraform/0.12.4/terraform_0.12.4_linux_amd64.zip && \
unzip terraform.zip && \
sudo mv terraform /usr/local/bin/terraform && echo "terraform installed"

echo "install ansible"
sudo apt update && sudo apt -y install python3 python3-pip
sudo pip3 install molecule && echo "ansible installed"

echo "Finish"
