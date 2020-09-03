#!/bin/bash
LOCAL_USER=${USER}
FEDORA_VERSION=`rpm -E %fedora`
PACKAGE_DIR=$HOME/automated-install/rpm
ansible-galaxy install -r requirements.yaml
sudo ansible-playbook provision-fedora-desktop.yaml -v --extra-vars="for_user=${LOCAL_USER} fedora_version=${FEDORA_VERSION} package_dir=${PACKAGE_DIR}"
