#!/bin/bash

sudo dnf -y install ansible git sshpass

#clone from GIT
git clone https://github.com/billwheatley/provision-desktop.git

./bootstrap-common.sh


