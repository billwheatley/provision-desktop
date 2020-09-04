#!/bin/bash

LOCAL_USER=${USER}

AUTOMATED_INSTALL_HOME=$HOME/automated-install
PACKAGE_DIR=$AUTOMATED_INSTALL_HOME/deb
OC_ARCHIVE=$AUTOMATED_INSTALL_HOME/archive/oc.tar.gz

ansible-galaxy install -f -r requirements.yaml
sudo ansible-playbook provision-apt-desktop.yaml -v --extra-vars="for_user=${LOCAL_USER} oc_archive=${OC_ARCHIVE}"
