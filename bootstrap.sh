#!/bin/bash

if [ -x "$(command -v apt-get)" ]; then 
    sudo apt-get update
    sudo apt-get -y install ansible git sshpass
elif [ -x "$(command -v dnf)" ]; then 
    sudo dnf -y install ansible git sshpass
elif [ -x "$(command -v yum)" ]; then 
    sudo yum -y install ansible git sshpass
else 
    echo Not sure which package manager is running on this machine
    exit 1
fi

#clone from GIT
git clone https://github.com/billwheatley/provision-desktop.git
echo ======
sleep 1
cd provision-desktop/
git checkout ssh_key_gen_ownership_issue_64
cd ..
echo ======

# Make sure plain 'python' is in path (ansible does not do will without it)
if [ ! `which python` ]; then
  PYTHON3_LOC=$(which python3)
  PYTHON_LOC=$(dirname $PYTHON3_LOC)/python
  echo Need to Link $PYTHON3_LOC $PYTHON_LOC [using sudo]
  sudo ln -s $PYTHON3_LOC $PYTHON_LOC
fi

# Make Roles-dir
mkdir desktop-roles

# Make automated install dirs
mkdir -p $HOME/automated-install/

#Call key setup playbook
PRIMARY_USER_GROUP=`id -gn`
cd provision-desktop
ansible-playbook key-setup.yaml --extra-vars="localhost_user=${USER} localhost_user_group=${PRIMARY_USER_GROUP} ansible_user_dir=${HOME}"

