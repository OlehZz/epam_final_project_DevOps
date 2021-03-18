#! /bin/sh
sudo apt-get -y update
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt install -y docker-ce
sudo systemctl start docker
sudo usermod -a -G docker ubuntu
sudo apt-get install -y python-pip
sudo pip install docker-py
sudo apt-get install -y awscli
sudo $(aws ecr get-login --no-include-email --region us-east-1)
sudo docker pull 622371100744.dkr.ecr.us-east-1.amazonaws.com/olehzz_footgo
sudo docker run -d --name footgo -p 8080:8080 622371100744.dkr.ecr.us-east-1.amazonaws.com/olehzz_footgo