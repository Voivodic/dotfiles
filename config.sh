#!/bin/bash

# Create the configuration file if not present
mkdir -p $HOME/.config

# Create the symbolic links with the configurations
ln -s $PWD/starship/starship.toml $HOME/.config/starship.toml
ln -s $PWD/nvim $HOME/.config/nvim 
mkdir -p $HOME/.config/tmux
ln -s $PWD/tmux/plugins $HOME/.config/tmux/plugins
ln -s $PWD/tmux/.tmux.conf $HOME/.tmux.conf
ln -s $PWD/nushell $HOME/.config/nushell

# Add the initialization of tmux and nushell on .bashrc
bashrc = "# Check if the script is running inside a tmux session\n\
if [ -z "$TMUX" ]; then\n\
    # Start a new tmux session and run nushell\n\
    tmux new-session -s main 'nu; exit; exit'\n\
else\n\
    # Just run nushell\n\
    nu; exit\n\
fi"
if ! grep -qF $bashrc ~/.bashrc; then
        echo $bashrc >> ~/.bashrc
fi
   
source $HOME/.bashrc
