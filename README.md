# provision-desktop Ansible playbooks

What I use to Provision my personal Desktops with Ansible. The goal is to create a playbooks (and related roles in other repos) to quickly provision: dnf/fedora and ubuntu/apt based systems for my desktop general usage.  This is not meant to be a highly generic set of playbooks that should work on anyone's hardware and OS, its more for me and for others to get a starting place on their fork.

## Current State

* dnf/fedora is tested and target to Fedora 32 KDE Spin, from fresh install
* apt is tested and target to Pop 20.04 LTS, from fresh install

## Bootstrap

Boot Strap Functions:

* Install Ansible and GIT
* Get these playbooks on your machine
* Generate ssh keys

From a directory you want to store these (ex: `~/dev/desktop-ansible/`)

From the prescribed starting point in the [Current State  Section](#current-state), do the following as your main admin/sudo user (do not sudo the call, that is done in the script):

### dnf bootstrap

`curl -s https://raw.githubusercontent.com/billwheatley/provision-desktop/master/bootstrap-dnf.sh | bash`

### apt bootstrap

`curl -s https://raw.githubusercontent.com/billwheatley/provision-desktop/master/bootstrap-apt.sh | bash`

## (Optional) Prepare Git Repo for Pushing

If you plan on pushing changes from the clone of this repo created by the bootstrap there are several steps you need to remember to take.

### Setup your new key in Git Hub

The bootstrap created an ssh key and you will need to associate that to the Github account that has access to this repo

Copy your public key:

```console
cat ~/.ssh/id_rsa.pub
```

Add your new SSH Key public key in [Github SSH Key Settings](https://github.com/settings/keys)

### Change Remote Repo to an SSH type

```console
git remote set-url origin git@github.com:billwheatley/provision-desktop.git
```

### Set your email

Make sure GitHub associates check-ins with your account.

```console
git config user.email theGitHubEmailYouUse@someservice.com
```

## (Optional) Packages not in Repositories

Sometimes we have those random `rpms` and `debs` that are not in public repos most because of distribution restrictions. Short of private repos, an easy solution is maintaining a local directory of these is just to drop these into a folder and this will pick up and install them.

### Fedora

Place your `rpms` in `$HOME/automated-install/rpm/`

If you have dependent `rpms` make sure they are also in the dir, these will be installed in a single command and `rpm` will figure out the dependencies. If your dependencies are packages in repos make sure those are added to one of the package repos. Those will be run before this.

This directory is not required if you have no `rpms` outside a repo.

Note: currently the is no automated upgrade of local rpms, see [issue #14](https://github.com/billwheatley/provision-desktop/issues/14)

### Pop / Ubuntu

*Coming soon*

## Running

Do the following as your main admin/sudo user (do not sudo the call, that is done in the script):

```console
./provision-localhost.sh
```

This script has the ability to automatically discover the following package managers and run the appropriate playbook, those are:

* dnf
* apt

### Optional Execution Options

The script is designed to be run without any options however there are custom behaviors, you can use the `-h` option to see a current list of options:

```console
./provision-localhost.sh -h
```
