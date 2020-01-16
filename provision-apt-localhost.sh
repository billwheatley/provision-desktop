#!/bin/bash
LOCAL_USER=${USER}
sudo ansible-playbook provision-apt-desktop.yaml --extra-vars="for_user=${LOCAL_USER}"
