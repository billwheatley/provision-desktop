#!/bin/bash
LOCAL_USER=${USER}
ansible-galaxy install -r requirements.yml
sudo ansible-playbook provision-apt-desktop.yaml -v --extra-vars="for_user=${LOCAL_USER}"
