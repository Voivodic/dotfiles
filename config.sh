#!/bin/bash

# Parse the command-line arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --env)
            if [ -n "$2" ]; then
                ENV_TYPE="$2"
                shift
            else
                echo "Error: --env requires an argument (personal or vps)."
                exit 1
            fi
            ;;
        *)
            echo "Unknown parameter passed: $1"
            exit 1
            ;;
    esac
    shift
done

# Setup for personal machine
if [ "$ENV_TYPE" = "personal" ]; then
    echo "Running personal setup..."

    # Remove all current configurations
    rm -rf $HOME/.config/starship.toml $HOME/.config/nvim $HOME/.tmux.conf $HOME/.tmux/plugins $HOME/.config/nushell $HOME/.bashrc $HOME/.profile $HOME/.config/nix $HOME/.config/ghostty $HOME/.config/hypr $HOME/.config/swaync $HOME/.config/themes $HOME/.config/wal $HOME/.config/waybar $HOME/.config/waypaper $HOME/.config/wlogout $HOME/.config/wofi $HOME/.config/zed $HOME/.ssh/config

    # Create the configuration file if not present
    mkdir -p $HOME/.config
    mkdir -p $HOME/.ssh

    # Create the symbolic links with the configurations
    ln -s $PWD/starship/starship.toml $HOME/.config/starship.toml
    ln -s $PWD/nvim $HOME/.config/nvim 
    ln -s $PWD/tmux/tmux.conf $HOME/.tmux.conf
    ln -s $PWD/nushell $HOME/.config/nushell
    ln -s $PWD/bashrc $HOME/.bashrc  
    ln -s $PWD/profile $HOME/.profile
    ln -s $PWD/nix $HOME/.config/nix
    ln -s $PWD/ghostty $HOME/.config/ghostty
    ln -s $PWD/hyprland/hypr $HOME/.config/hypr
    ln -s $PWD/hyprland/swaync $HOME/.config/swaync
    ln -s $PWD/themes $HOME/.config/themes
    ln -s $PWD/hyprland/wal $HOME/.config/wal
    ln -s $PWD/hyprland/waybar $HOME/.config/waybar
    ln -s $PWD/hyprland/waypaper $HOME/.config/waypaper
    ln -s $PWD/hyprland/wlogout $HOME/.config/wlogout
    ln -s $PWD/hyprland/wofi $HOME/.config/wofi
    ln -s $PWD/zed $HOME/.config/zed
    ln -s $PWD/ssh/config $HOME/.ssh/config

    # Download tmp to add plugins to tmux
    rm -rf $HOME/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm.git $HOME/.tmux/plugins/tpm
    . $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh

    # Source the new bashrc
    source $HOME/.bashrc

# Setup for vps
elif [ "$ENV_TYPE" = "vps" ]; then
    echo "Running vps setup..."

    # Remove all current configurations
    rm -rf $HOME/.config/starship.toml $HOME/.config/nvim $HOME/.tmux.conf $HOME/.tmux/plugins $HOME/.config/nushell $HOME/.bashrc $HOME/.profile $HOME/.config/nix $HOME/.ssh/config

    # Create the configuration file if not present
    mkdir -p $HOME/.config
    mkdir -p $HOME/.ssh

    # Create the symbolic links with the configurations
    ln -s $PWD/starship/starship.toml $HOME/.config/starship.toml
    ln -s $PWD/nvim $HOME/.config/nvim 
    ln -s $PWD/tmux/tmux.conf $HOME/.tmux.conf
    ln -s $PWD/nushell $HOME/.config/nushell
    ln -s $PWD/bashrc $HOME/.bashrc  
    ln -s $PWD/profile $HOME/.profile
    ln -s $PWD/nix $HOME/.config/nix
    ln -s $PWD/ssh/config $HOME/.ssh/config

    # Download tmp to add plugins to tmux
    rm -rf $HOME/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tpm.git $HOME/.tmux/plugins/tpm
    . $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh

    # Source the new bashrc
    source $HOME/.bashrc

else
    echo "Unknown environment. Skipping setup."
fi
