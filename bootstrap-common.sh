#!/bin/bash

# Make sure plain 'python' is in path (ansible does not do will without it)
if [ ! `which python` ]; then
  PYTHON3_LOC=$(which python3)
  PYTHON_LOC=$(dirname $PYTHON3_LOC)/python
  echo Need to Link $PYTHON3_LOC $PYTHON_LOC [using sudo]
  sudo ln -s $PYTHON3_LOC $PYTHON_LOC
fi

# Make Roles-dir
mkdir ../desktop-roles

# Make automated install dirs
mkdir -p $HOME/automated-install/

#Call key setup playbook
ansible-playbook key-setup.yaml --extra-vars='localhost_user="${USER}" ansible_user_dir="${HOME}"'

