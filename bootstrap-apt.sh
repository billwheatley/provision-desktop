#!/bin/bash

sudo apt-get update
sudo apt-get -y install ansible git sshpass

#clone from GIT
git clone https://github.com/billwheatley/provision-desktop.git

./provision-desktop/bootstrap-common.sh
