#!/bin/bash

# Makr Roles-dir
mkdir ../desktop-roles

# TODO get roles from git

#TODO cd into git dir
#Call key setup playbook
LOCAL_USER=${USER}
LOCAL_USER_HOME=${HOME}
sudo ansible-playbook key-setup.yaml --extra-vars='localhost_user="${LOCAL_USER}" ansible_user_dir="${LOCAL_USER_HOME}"'

# This is not working on nas
# ssh-copy-id -i ~/.ssh/id_rsa.pub bwheatley@nas.local
#changed /etc/ssh/sshd_config on the server contains PubkeyAuthentication yes. Remember to restart the sshd process on the server: nohup synoservicectl --restart sshd &
