#!/bin/bash

# Create the configuration file if not present
mkdir -p $HOME/.config

# Create the symbolic links with the configurations
ln -s $PWD/starship/starship.toml $HOME/.config/starship.toml
ln -s $PWD/nvim $HOME/.config/nvim 
ln -s $PWD/tmux $HOME/.config/tmux
ln -s $PWD/tmux/tmux.conf $HOME/.tmux.conf
ln -s $PWD/nushell $HOME/.config/nushell
ln -s $PWD/bashrc $HOME/.bashrc  

source $HOME/.bashrc
