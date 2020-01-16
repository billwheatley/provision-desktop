#!/bin/bash
LOCAL_USER=${USER}
sudo ansible-playbook provision-dnf-desktop.yaml --extra-vars='for_user="${LOCAL_USER}" fedora_version="`rpm -E %fedora`"'
