#!/bin/bash

sudo yum -y install ansible git sshpass

#clone from GIT
git clone https://github.com/billwheatley/provision-desktop.git

cd provision-desktop
./bootstrap-common.sh


