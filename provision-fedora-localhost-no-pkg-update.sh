#!/bin/bash

LOCAL_USER=${USER}
FEDORA_VERSION=`rpm -E %fedora`

AUTOMATED_INSTALL_HOME=$HOME/automated-install
PACKAGE_DIR=$AUTOMATED_INSTALL_HOME/rpm
OC_ARCHIVE=$AUTOMATED_INSTALL_HOME/archive/oc.tar.gz

ansible-galaxy install -f -r requirements.yaml
sudo ansible-playbook provision-fedora-desktop.yaml -v --extra-vars="for_user=${LOCAL_USER} fedora_version=${FEDORA_VERSION} package_dir=${PACKAGE_DIR} oc_archive=${OC_ARCHIVE}" --skip-tags "pkg_update"
