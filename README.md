# provision-desktop Ansible playbooks

What I use to Provision my personal Desktops with Ansible. The goal is to create a playbooks (and related roles in other repos) to quickly provision both dnf, and apt based systems for my desktop general usage.

## Current State NOTICE

This is a bit messy right now, use with caution.

## Bootstrap

Boot Strap Functions:

* Install Ansible and GIT
* Get these playbooks on your machine
* Generate ssh keys
* Set keys up with dependent machines

From a directory you want to store these (ex: `~/dev/desktop-ansible/`)

From a fresh OS install, do the following as your main admin/sudo user (do not sudo the call, that is done in the script):

### dnf bootstrap

`curl -s https://raw.githubusercontent.com/billwheatley/provision-desktop/master/bootstrap-dnf.sh | bash`

### apt bootstrap

`curl -s https://raw.githubusercontent.com/billwheatley/provision-desktop/master/bootstrap-apt.sh | bash`

## Running

On a regular basis (every time you make a change or just need to get the system back in order or up to speed).

Do the following as your main admin/sudo user (do not sudo the call, that is done in the script):

### dnf running

TODO

### apt running

`./provision-apt-localhost.sh`
