# Project Naming Goals

## Purpose

To Set standards for naming and clearly understanding what playbooks and Roles I write do and for what distro.

## Specific vs General naming

* In Playbooks if you are targeting and testing PopOS call it "PopOs" even if you generally believe it will run on Ubuntu, Debian, etc.
* Same is true for Fedora, RHEL, CentOS, etc
  * If it runs on 2 or more Red Hat distro types call it "Red Hat" or "RH"
* If you test something and it runs on Ubuntu and PopOs you can call it Ubuntu since Pop is built on Ubuntu.

### Roles are package manger name based unless specifically written to a distro

There are some modifications to Roles standards, since Pop is obscure in the role world and what I am doing is very likely transferable to Ubuntu we could probably call it Ubuntu w/o testing and it is reasonably assumed to work.

## Package Manager and Packages

* Package Manager does not imply OS
  * Figure out the OS if necessary to meet the goals laid out here.

### Bootstrap Script is package manger name based

* The boot strap script is pretty generic and can stay package manger name based:
  * `apt-get` logic/packages should work for any Debian/Ubuntu/PopOs or alternatives with basic repos installed.
  * `dnf` logic/packages should work for Fedora/RHEL/CentOS system or alternatives with basic repos installed.
  * all common logic is really basic GNU/Linux stuff

## Automated Testing and Pipelines needed

Naming and reuse by others could become better with some automated testing of some other distros.