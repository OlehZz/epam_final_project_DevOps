#!/bin/bash
sudo apt-get -y update
sudo apt-get -y install openjdk-8-jdk
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo add-apt-repository "deb https://pkg.jenkins.io/debian-stable binary/"
sudo apt-get -y install jenkins
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get -y install ansible
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get -y install terraform
sudo apt-get install -y python-pip
sudo pip install boto3
sudo pip install botocore
