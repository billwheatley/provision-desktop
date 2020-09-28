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

## Packages not in Repositories

Sometimes we have those random `rpms` and `debs` that are not in public repos most because of distribution restrictions. Short of private repos, an easy solution is maintaining a local directory of these is just to drop these into a folder and this will pick up and install them. Updating these in most cases should be easy just add the new rpm and delete the old. These will be installed after the repo packages are installed.

### Fedora

Place your `rpms` in `$HOME/automated-install/rpm/`

If you have dependent `rpms` make sure they are also in the dir, these will be installed in a single command and `rpm` will figure out the dependencies. If your dependencies are packages in repos make sure those are added to one of the package repos. Those will be run before this.

This directory is not required if you have no `rpms` outside a repo.

### Pop / Ubuntu

*Coming soon*

## Misc Software in tar.gz files

Sometimes we have things not even in nice clean packages and those come from things like `tar.gz` files then we need to install those, unlike `rpms` and `debs` we will need to add custom declarations to install these.  If I keep with my design principals going forward the declarations should be in individual roles.

The following is what is currently supported

### oc (optional)

This is the official certified `oc` tool from Red Hat, this is behind a pay wall at <https://access.redhat.com> and is distributed as a `.tar.gz` file.  This should work with an unofficial `oc` archive (that is publicly available) as well, the `.tar.gz` file just needs to have the `oc` binary at the root of the archive

Place oc tar.gz in `$HOME/automated-install/archive` once downloaded

Then create a sym link from `oc.tar.gz` to the specific version (or rename the archive if you prefer). Example:

```console
ln -s oc-4.5.7-linux.tar.gz oc.tar.gz
```

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
