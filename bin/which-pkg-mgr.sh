#!/bin/bash

#Figures out what package manager the system has, currently supported: dnf, yum, apt-get, NA

if [ -x "$(command -v apt-get)" ]; then 
    echo apt-get
elif [ -x "$(command -v dnf)" ]; then 
    echo dnf
elif [ -x "$(command -v yum)" ]; then 
    echo yum
else 
    echo NA
    exit 1
fi
