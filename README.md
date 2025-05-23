# provision-desktop Ansible playbooks

What I use to Provision my personal Desktops with Ansible. The goal is to create a playbooks (and related roles in other repos) to quickly provision my desktops. Typically I am using the latest distros (listed below) for my desktop general usage.  This is not meant to be a highly generic set of playbooks that should work on anyone's hardware and OS, its more for me and for others to get a starting place.

## Current State

These are currently designed and tested to be run with a vanilla install + any [manual pre-reqs](#manual-prerequisite) + [bootstrap](#bootstrap) script for the following distros:

* Fedora 42 KDE Desktop Spin
* OpenMandriva Rome
  * Tested with 2025-04-28 Plasma 6 Wayland (full) x86_64 snapshot iso
  * Tested with 2025-04-28 Plasma 6 x11 (full) AMD snapshot iso
  * Tested with 2025-05-05 Plasma 6 Wayland (full) AMD snapshot iso

*Note: These may work against other similar versions and distros with little or no modification*

Once initially provisioned these are designed to be run over and over again for any updates to the playbooks, Ansible roles or updates to the software that is being installed.  Generally these playbooks ensure you have the latest software running for the distro you are running as I try to avoid version pinning.

These mostly focus on software installs and some OS config specific to the OS. The source of the software varies depending on availability and this servers as a one-stop all encompassing update of my system, here are some of the sources:

* Distro default repos
* Distro extended repos
* 3rd party repos
* Direct rpm downloads
* [Locally present](#optional-packages-not-in-repositories) rpms
* tar.gz downloads
* flatpaks
* snaps (being depreciated)
* pip repo
* vsCode extension marketplace

### Past State

If you look in git [history](https://github.com/billwheatley/provision-desktop/tree/3192327b38085961d01873dbe8be4eed056fb027) you will find the following distros that I no longer use and have been removed to simplify the playbooks:

* Pop OS 22.04
* Nobara 41

### Local execution

Currently these playbooks where designed for local execution. Meaning the command node and managed node are the same. These are all run on and against `localhost`.

## Manual Prerequisite

### Optional Hostname

If the distro installer didn't set a hostname, now would be a good time.

```console
sudo hostnamectl set-hostname <new hostname>
```

## Bootstrap

### Main Bootstrap

Bootstrap Functions:

* Install Ansible, git and sshpass
  * GNU Tar on Open Mandriva (for Ansible)
* Get these playbooks on your machine
* Ensure "`python`" (without numbers) is in the path for Ansible
* Generate ssh keys for the local user

As your main admin/sudo user (do not sudo the call, that is done in the script):

```console
cd ~
mkdir -p ~/dev/ansible-desktop
cd ~/dev/ansible-desktop
curl -s https://raw.githubusercontent.com/billwheatley/provision-desktop/master/bootstrap.sh | bash -
```

## (Optional) Prepare Git Repo for Pushing

If you plan on pushing changes from the clone of this repo created by the bootstrap there are several steps you need to remember to take.

### Setup your new key in GitHub

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

Sometimes we have those random `rpms` that are not in public repos most because of distribution restrictions. Short of private repos, an easy solution is maintaining a local directory of these is just to drop these into a folder and this will pick up and install them.

### RPM Distros

Place your `rpms` in `$HOME/automated-install/rpm/`

If you have dependent `rpms` make sure they are also in the dir, these will be installed in a single command and `rpm` will figure out the dependencies. If your dependencies are packages in repos make sure those are added to one of the package repos. Those will be run before this.

This directory is not required if you have no `rpms` outside a repo.

Note: currently there is no automated upgrade of local rpms, see [issue #14](https://github.com/billwheatley/provision-desktop/issues/14)

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

## (Optional) Reboot / Restart when you are done

I do any automatic reboots of the system. However I leave that decision up to the user.  Generally I recommend a reboot after the following:

* Initial provision
* Large package manager update
* Any package update to:
  * The kernel
  * KDE Plasma / QT
  * Core system libraries

Other times a simple restart of the application may be all that is nessasary, especially for browser updates (you don't get promoted like Windows or Mac versions for browser restarts)
