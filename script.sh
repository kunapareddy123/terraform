#!/bin/bash
# Enable PasswordAuthentication in /etc/ssh/sshd_config
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
# restart service sshd
sudo service sshd restart
# change password for root
sudo echo root:devops | sudo chpasswd 
# install ansible
sudo yum install epel-release -y
sudo yum install ansible -y
# create ssh-keygen
ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa 2>/dev/null <<< y >/dev/null
sudo yum install sshpass -y 
# copy id to the localhost
sshpass -p "devops" ssh-copy-id -o StrictHostKeyChecking=no root@localhost
#execute playbook
ansible-playbook -i /tmp/hosts /tmp/deployment.yml
