#!/usr/bin/env bash
#
# Steez up that computer

source helpers.sh

# Check to see that the installer will
# work on the operating system
if [[ ! ${SSUPPORTED[@]} =~ "$SOS" ]]; then
    echo "$SOS is not supported"

    exit 0
fi

# I mean.... Why wouldn't this be installed by now?
if [[ ! -f /usr/bin/git ]]; then
    steez_install git
fi

# Install fish as the first thing if it is
# not currently installed
FISH_PATH=/usr/bin/fish
if [[ ! -f $FISH_PATH ]]; then
    steez_install fish
fi

# Make fish better
if [[ ! -d $HOME/.local/share/omf ]]; then
    echo "Installing Oh My Fish"
    curl -L https://get.oh-my.fish | fish
fi


# Make fish prettier
if [[ ! -d $HOME/.local/share/omf/themes/agnoster ]]; then
    echo "Installing Agnoster OMF Theme"
    fish -c "omf install agnoster"
fi

# Check to see if shell is Fish 
# otherwise you should log out
if [[ $SHELL != $FISH_PATH ]]; then
    echo "Setting $SHELL to be $FISH_PATH"
    chsh -s $FISH_PATH

    echo "You will need to log back in to continue to steez"
    
    exit 0
fi

# Add additional repositories
if [[ $SOS == "Fedora" ]]; then
    source repos/fedora.sh
fi

# Install required applications
steez_install \
    code \
    code-insiders \
    composer \
    containerd.io \
    curl \
    docker-ce \
    docker-ce-cli \
    docker-compose \
    git \
    nodejs \
    php \
    sublime-text \
    vim

# Make sure PHP 7.0 is also installed
if [[ $SOS == "Fedora" && ! -f /usr/bin/php70 ]]; then
    sudo dnf module install php:remi-8.0
    sudo dnf install php70
fi
