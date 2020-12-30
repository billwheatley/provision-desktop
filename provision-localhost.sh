#!/bin/bash

OPTIND=1         # Reset in case getopts has been used previously in the shell.

function show_help {
    echo Provision your PopOS or fedora desktops
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

LOCAL_USER=${USER}

# Determine skip tags
if [ ! -z ${skip_tags} ]; then
    skip_tag_directive="--skip-tags $skip_tags"
fi

#Update roles if not skipped 
if [ ! "$role_updates" == "skip" ]; then
    ansible-galaxy install -f -r requirements.yaml
fi

sudo ansible-playbook provision.yaml -v --extra-vars="for_user=${LOCAL_USER}" ${skip_tag_directive}
