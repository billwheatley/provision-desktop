#!/bin/bash

OPTIND=1         # Reset in case getopts has been used previously in the shell.

function show_help {
    echo Provision your PopOS or fedora desktops
    echo 
    echo OPTIONS:
    echo "   -p      Skip Package Manager Updates (does not disable updates from roles)"
    echo "   -r      Skip Role Definition Updates"
    echo "   -s      Skip Snap Package Install/Updates (useful if store is down)"
}

# Function to add or update the skip tag list
function add_skip_tag {
    if [ -z ${skip_tags} ]; then
        skip_tags="$1"
    else
        skip_tags="$skip_tags,$1"    
    fi
}

while getopts "hprs" opt; do
    case "$opt" in
    h)
        show_help
        exit 0
        ;;
    p)  
        add_skip_tag "pkg_update"
        ;;
    r)  
        role_updates="skip"
        ;;
    s)  
        add_skip_tag "snap_pkgs"
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
