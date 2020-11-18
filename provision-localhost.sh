#!/bin/bash

OPTIND=1         # Reset in case getopts has been used previously in the shell.

function show_help {
    echo Provision your apt or fedora desktops
    echo 
    echo OPTIONS:
    echo "   -p      Skip Package Manager Updates (does not disable updates from roles)"
    echo "   -r      Skip Role Updates"
}

while getopts "hpr" opt; do
    case "$opt" in
    h)
        show_help
        exit 0
        ;;
    p)  
        skip_tags="pkg_update"
        ;;
    r)  
        role_updates="skip"
        ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

DIRNAME=`dirname "$0"`
PKG_MGR=`$DIRNAME/bin/which-pkg-mgr.sh`

LOCAL_USER=${USER}
AUTOMATED_INSTALL_HOME=${HOME}/automated-install

# Package manager / OS specific Vars
if [ "$PKG_MGR" == "dnf" ]; then
    OS_EXTRA_VARS="fedora_version=`rpm -E %fedora` package_dir=${AUTOMATED_INSTALL_HOME}/rpm"
    ENTRY_PLAYBOOK=provision-fedora-desktop.yaml
    
elif [ "$PKG_MGR" == "apt-get" ]; then
    OS_EXTRA_VARS="package_dir=${AUTOMATED_INSTALL_HOME}/deb" #<< Not currently used
    ENTRY_PLAYBOOK=provision-apt-desktop.yaml
fi

# Determine skip tags
if [ ! -z ${skip_tags} ]; then
    skip_tag_directive="--skip-tags $skip_tags"
fi


#Update roles if not skipped 
if [ ! "$role_updates" == "skip" ]; then
    ansible-galaxy install -f -r requirements.yaml
fi

sudo ansible-playbook ${ENTRY_PLAYBOOK} -v --extra-vars="for_user=${LOCAL_USER} ${OS_EXTRA_VARS}" ${skip_tag_directive}
