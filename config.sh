#!/bin/bash

# Remove all current configurations
rm -rf $HOME/.config/starship.toml $HOME/.config/nvim $HOME/.tmux.conf $HOME/.tmux/plugins $HOME/.config/nushell $HOME/.bashrc $HOME/.profile $HOME/.config/nix

# Create the configuration file if not present
mkdir -p $HOME/.config

# Create the symbolic links with the configurations
ln -s $PWD/starship/starship.toml $HOME/.config/starship.toml
ln -s $PWD/nvim $HOME/.config/nvim 
ln -s $PWD/tmux/tmux.conf $HOME/.tmux.conf
ln -s $PWD/nushell $HOME/.config/nushell
ln -s $PWD/bashrc $HOME/.bashrc  
ln -s $PWD/profile $HOME/.profile
ln -s $PWD/nix $HOME/.config/nix

# Download tmp to add plugins to tmux
git clone https://github.com/tmux-plugins/tpm.git $HOME/.tmux/plugins/tpm
. $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh

# Source the new bashrc
source $HOME/.bashrc
