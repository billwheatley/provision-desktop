#!/bin/bash

# For Open Mandriva repo file editing
safe_edit_repo_file() {
   grep -n "enabled" $1 |grep $2 >/dev/null
   if [ $? -eq 0 ]; then
       sed_exp=`echo $2`"s/.*/enabled=1/"
       sudo sed -i $sed_exp $1 
   else
       echo Unexpected Repo file format [$1], expecting enabled flag on line $2
       echo ERROR: Script can not enable required Repo, this script needs to be fixed
       exit 1
   fi
}

if [ -x "$(command -v dnf)" ]; then 
    if [ -f /etc/openmandriva-release ]; then
        echo Open Mandrivia Detected, additional repos need to be turned on now
        if [ -f /etc/yum.repos.d/openmandriva-rolling-x86_64.repo ]; then
            echo Detected x86_64 Variant
            repo_file=/etc/yum.repos.d/openmandriva-rolling-x86_64.repo
        elif [ -f /etc/yum.repos.d/openmandriva-rolling-znver1.repo ]; then
            echo Detected AMD Variant
            repo_file=/etc/yum.repos.d/openmandriva-rolling-znver1.repo
        fi
        sudo cp $repo_file $repo_file.backup
        echo Backup of repo file made if this fails: $repo_file.backup
        # Doing this by Line number
        safe_edit_repo_file $repo_file "59"
        safe_edit_repo_file $repo_file "107"
        safe_edit_repo_file $repo_file "155"

        # OM uses bsd-tar by default, Ansible needs gnu-tar, this will fix this (and it's not an official dependency of ansible in OM repos)
        sudo dnf -y install gnutar
    fi
    # Fedora/RH and OpenMandriva dnf bootstrap packages (these distros happen to use the same package names)
    sudo dnf -y install ansible git sshpass
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

#Need sudo on open-mandriva becuase facts plugin needs it
sudo ansible-playbook key-setup.yaml --extra-vars="localhost_user=${USER} localhost_user_group=${PRIMARY_USER_GROUP} ansible_user_dir=${HOME}"

