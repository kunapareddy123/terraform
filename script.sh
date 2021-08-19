#!/bin/bash
# Enable PasswordAuthentication in /etc/ssh/sshd_config
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
# restart service sshd
sudo service sshd restart
# change password for root
sudo echo root:devops | sudo chpasswd 
# install ansible
sudo apt-get install epel-release -y
sudo apt-get install ansible -y
# create ssh-keygen
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa 2>/dev/null <<< y >/dev/null
sudo apt-get install sshpass -y 
# copy id to the localhost
sshpass -p "devops" ssh-copy-id -o StrictHostKeyChecking=no root@localhost
#Install Java 8 with Ansible roles
sudo cp /tmp/deployment.yml /etc/ansible/roles
#execute playbook
ansible-playbook -i /tmp/hosts /tmp/deployment.yml