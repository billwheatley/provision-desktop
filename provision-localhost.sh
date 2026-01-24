#!/bin/bash

OPTIND=1         # Reset in case getopts has been used previously in the shell.

function show_help {
    echo Provision your Fedora CSB Desktop
    echo 
    echo OPTIONS:
    echo "   -p      Skip Package Manager Updates (does not disable updates from roles)"
    echo "   -r      Skip Requirements Definition Updates (ie: Roles and Collections)"
    echo "   -s      Skip Snap Package Install/Updates (useful if store is down)"
    echo "   -v      Verbose output"
}

# Function to add or update the skip tag list
function add_skip_tag {
    if [ -z ${skip_tags} ]; then
        skip_tags="$1"
    else
        skip_tags="$skip_tags,$1"    
    fi
}

verbose=""

while getopts "hprsv" opt; do
    case "$opt" in
    h)
        show_help
        exit 0
        ;;
    p)  
        add_skip_tag "pkg_update"
        ;;
    r)  
        requirements_updates="skip"
        ;;
    s)  
        add_skip_tag "snap_pkgs"
        ;;
    v)  
        verbose="-v"
        ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

LOCAL_USER=${USER}

# Determine skip tags
if [ ! -z ${skip_tags} ]; then
    skip_tag_directive="--skip-tags $skip_tags"
fi

#Update requirements if not skipped 
if [ ! "$requirements_updates" == "skip" ]; then
    ansible-galaxy install -f -r requirements.yaml
fi

sudo ansible-playbook provision.yaml ${verbose} --extra-vars="for_user=${LOCAL_USER} ${skip_tag_directive}"