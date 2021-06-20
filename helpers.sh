#!/usr/bin/env bash
#
# Steezy helpers

SOS=$(cat /etc/os-release | grep ^NAME | sed -e s/^NAME=//)

SSUPPORTED=(Fedora Ubuntu)

steez_install() {
    echo "Installing $@"
    
    if [[ $SOS == "Fedora" ]]; then
	    sudo dnf install $@
    fi

    if [[ $SOS == "Ubuntu" ]]; then
        sudo apt install $@
    fi
}
