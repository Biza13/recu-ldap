#!/bin/bash
sudo usermod -aG docker ec2-user
newgrp docker
sudo systemctl restart docker
sleep 30
source ~/.bashrc
sudo docker build -t ldap-img -f ./Dockerfile.LDAP .
sudo docker run -d --name ldap-container -p 636:636 -p 389:389 -e LDAP_ADMIN_PASSWORD="admin" ldap-img
sleep 30