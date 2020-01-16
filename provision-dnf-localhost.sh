#!/bin/bash
LOCAL_USER=${USER}
FEDORA_VERSION=`rpm -E %fedora`
sudo ansible-playbook provision-dnf-desktop.yaml --extra-vars='for_user="${LOCAL_USER}" fedora_version="${FEDORA_VERSION}"'
