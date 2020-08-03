# provision-desktop Ansible playbooks

What I use to Provision my personal Desktops with Ansible. The goal is to create a playbooks (and related roles in other repos) to quickly provision: dnf/fedora, yum/rhel and ubuntu/apt based systems for my desktop general usage.  This is not meant to be a highly generic set of playbooks that should work on anyone's hardware and OS, its more for me and for others to get a starting place on their fork.

## Current State NOTICE

* dnf/fedora is tested and target to Fedora 32, from fresh install
* apt is tested and target to Pop 20.04 LTS, from fresh install

## Bootstrap

Boot Strap Functions:

* Install Ansible and GIT
* Get these playbooks on your machine
* Generate ssh keys
* Set keys up with dependent machines (future)

From a directory you want to store these (ex: `~/dev/desktop-ansible/`)

From the prescribed starting point in "Current State NOTICE), do the following as your main admin/sudo user (do not sudo the call, that is done in the script):

### dnf bootstrap

`curl -s https://raw.githubusercontent.com/billwheatley/provision-desktop/master/bootstrap-dnf.sh | bash`

### apt bootstrap

`curl -s https://raw.githubusercontent.com/billwheatley/provision-desktop/master/bootstrap-apt.sh | bash`

## Running

Do the following as your main admin/sudo user (do not sudo the call, that is done in the script):

### fedora running

`./provision-fedora-localhost.sh`

or

`./provision-fedora-localhost-no-pkg-update.sh` if you don't want to skip package updates

### apt running

`./provision-apt-localhost.sh`

or

`./provision-apt-localhost-no-pkg-update.sh` if you don't want to skip package updates
