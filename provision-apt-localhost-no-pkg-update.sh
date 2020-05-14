#!/bin/bash
LOCAL_USER=${USER}
sudo ansible-playbook provision-apt-desktop.yaml -v --extra-vars="for_user=${LOCAL_USER}" --skip-tags "pkg_update"
