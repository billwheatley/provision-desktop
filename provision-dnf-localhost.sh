#!/bin/bash
LOCAL_USER=${USER}
FEDORA_VERSION=`rpm -E %fedora`
ansible-galaxy install -r requirements.yaml
sudo ansible-playbook provision-dnf-desktop.yaml -v --extra-vars="for_user=${LOCAL_USER} fedora_version=${FEDORA_VERSION}"
