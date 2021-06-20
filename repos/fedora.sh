#!/usr/bin/env bash
#
# Fedora repos


SREPO=$(dnf repolist | grep 'Docker')

if [[ ! $SREPO ]]; then
    echo " * Repository: Docker Engine"

    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
fi


SREPO=$(dnf repolist | grep 'sublime-text')

if [[ ! $SREPO ]]; then
    echo " * Repository: Adding Sublime Text"

    sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
fi


if [[ ! -f /etc/yum.repos.d/vscode.repo ]]; then 
    echo " * Repository: VS Code"

    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
fi


SREPO=$(dnf repolist | grep "Remi's RPM repository - Fedora 34")

if [[ ! $SREPO ]]; then
    echo " * Repository: Adding Remi Release 34"

    sudo dnf -y install https://rpms.remirepo.net/fedora/remi-release-34.rpm
    sudo dnf config-manager --set-enabled remi
    sudo dnf module reset php
fi


sudo dnf check-update
