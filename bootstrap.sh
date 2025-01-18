#!/bin/bash

# For Open Mandriva repo file editing
safe_edit_repo_file() {
   grep -n "enabled" /etc/yum.repos.d/openmandriva-rolling-x86_64.repo |grep $1 >/dev/null
   if [ $? -eq 0 ]; then
       sed_exp=`echo $1`"s/.*/enabled=1/"
       sudo sed -i $sed_exp /etc/yum.repos.d/openmandriva-rolling-x86_64.repo 
   else
       echo Unexpected Repo file format [/etc/yum.repos.d/openmandriva-rolling-x86_64.repo], expecting enabled flag on line $1
       echo ERROR: Script can not enable required Repo, this script needs to be fixed
       exit 1
   fi
}

if [ -x "$(command -v apt-get)" ]; then 
    sudo apt-get update
    sudo apt-get -y install ansible git sshpass
elif [ -x "$(command -v dnf)" ]; then 
    if [ -f /etc/openmandriva-release ]; then
	echo Open Mandrivia Detected, additional repos need to be turned on now
	sudo cp /etc/yum.repos.d/openmandriva-rolling-x86_64.repo /etc/yum.repos.d/openmandriva-rolling-x86_64.repo.backup
	echo Backup of repo file made if this fails: /etc/yum.repos.d/openmandriva-rolling-x86_64.repo.backup
	# Doing this by Line number
	safe_edit_repo_file "59"
	safe_edit_repo_file "107"
	safe_edit_repo_file "155"
    fi
    sudo dnf -y install ansible git sshpass
elif [ -x "$(command -v yum)" ]; then 
    sudo yum -y install ansible git sshpass
else 
    echo Not sure which package manager is running on this machine
    exit 1
fi

#clone from GIT
git clone https://github.com/billwheatley/provision-desktop.git

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

