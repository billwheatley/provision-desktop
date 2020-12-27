# provision-desktop Ansible playbooks

What I use to Provision my personal Desktops with Ansible. The goal is to create a playbooks (and related roles in other repos) to quickly provision: fedora and PopOS systems for my desktop general usage.  This is not meant to be a highly generic set of playbooks that should work on anyone's hardware and OS, its more for me and for others to get a starting place on their fork.

## Current State

* fedora playbooks and roles are tested and target to Fedora 33 KDE Spin (Currently [Issue #22](https://github.com/billwheatley/provision-desktop/issues/22) exists with work arounds)
* Pop is tested and target to Pop 20.10 LTS with KDE

### Local execution

Currently these playbooks where designed for local execution. Meaning the command node and managed node are the same. These are all run on and against `localhost`.

## PopOS with KDE

If you want to install KDE in Pop (which is what is tested) then before you install the bootstrap run a one time script:

```console
# NOTE: Change to master when merged
curl -s https://raw.githubusercontent.com/billwheatley/provision-desktop/pop_os_20_10/pre-pop-kde.sh | bash
```

NOTE: this is a temporary step until [issue 8](https://github.com/billwheatley/provision-desktop/issues/8) is solved

## Bootstrap

Bootstrap Functions:

* Install Ansible, git and sshpass (compatible with apt-get, dnf or yum package managers)
* Get these playbooks on your machine
* Ensure "`python`" (without numbers) is in the path for Ansible
* Generate ssh keys for the local user

From a directory you want to store these (ex: `~/dev/desktop-ansible/`)

From the prescribed starting point in the [Current State  Section](#current-state), do the following as your main admin/sudo user (do not sudo the call, that is done in the script):

```console
curl -s https://raw.githubusercontent.com/billwheatley/provision-desktop/master/bootstrap.sh | bash
```

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

### Set your name and email

Since these instructions are often done right after a fresh install, remember:

* Set your name globally.
* Configure just this repo's email address to the one associated with your GitHub account.

```console
git config --global user.name "Bill Wheatley"
git config user.email theGitHubEmailYouUse@someservice.com
```

## (Optional) Packages not in Repositories

Sometimes we have those random `rpms` and `debs` that are not in public repos most because of distribution restrictions. Short of private repos, an easy solution is maintaining a local directory of these is just to drop these into a folder and this will pick up and install them.

### Fedora

Place your `rpms` in `$HOME/automated-install/rpm/`

If you have dependent `rpms` make sure they are also in the dir, these will be installed in a single command and `rpm` will figure out the dependencies. If your dependencies are packages in repos make sure those are added to one of the package repos. Those will be run before this.

This directory is not required if you have no `rpms` outside a repo.

Note: currently there is no automated upgrade of local rpms, see [issue #14](https://github.com/billwheatley/provision-desktop/issues/14)

### Pop / Ubuntu

*Coming soon*

## Running

Do the following as your main admin/sudo user (do not sudo the call, that is done in the script):

```console
./provision-localhost.sh
```

### Optional Execution Options

The script is designed to be run without any options however there are custom behaviors, you can use the `-h` option to see a current list of options:

```console
./provision-localhost.sh -h
```
