#!/bin/bash

# Create the configuration file if not present
mkdir -p $HOME/.config/

# Create the symbolic links with the configurations
ln -s starship/starship.toml $HOME/.config/starship.toml
ln -s /nvim $HOME/.config/nvim 
ln -s /tmux/plugins $HOME/.config/tmux/plugins
ln -s tmux/.tmux.conf $HOME/.tmux.conf
ln -s /nushell $HOME/.config/nushell

# Add the initialization of tmux and nushell on .bashrc
echo -e "# Check if the script is running inside a tmux session\n\
if [ -z "$TMUX" ]; then\n\
    # Start a new tmux session and run nushell\n\
    tmux new-session -s main 'nu; exit; exit'\n\
else\n\
    # Just run nushell\n\
    nu; exit\n\
fi" >> $HOME/.bashrc

source $HOME/.bashrc
