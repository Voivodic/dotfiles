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

# Check if curl is installed
if ! command -v curl >/dev/null 2>&1; then
     echo "curl is not installed! Please install curl to proceed.\n"
     exit 1
fi

# Check if nix is already running
if [ -z "$NIX_GCROOT" ]; then
    # Install nix (multi-user)
    echo -e "Installing nix...\n"
    {
        sh <(curl -L https://nixos.org/nix/install) --no-daemon
    } && echo -e "Nix installed!\n" || {
        echo -e "An error ocurred while trying to install nix!\n"
        exit 1
    }

    # Source the nix profile script
    echo -e "Sourcing nix profile...\n"
    {
        . $HOME/.nix-profile/etc/profile.d/nix.sh 
    } && echo -e "Nix sourced!\n" || {
        echo -e "An error ocurred while trying to source nix!\n"
        exit 1
    }
fi

# Setup for personal machine
if [ "$ENV_TYPE" = "personal" ]; then
    echo "Running personal setup..."

    # Create the configuration folders (if not present)
    echo "Creating configuration folders..."
    mkdir -p $HOME/.config
    mkdir -p $HOME/.ssh

    # Create the symbolic links with the configurations
    echo "Creating symbolic links..."
    ln -sf $PWD/starship/starship.toml $HOME/.config/starship.toml
    ln -sf $PWD/nvim $HOME/.config/nvim 
    ln -sf $PWD/tmux/tmux.conf $HOME/.tmux.conf
    ln -sf $PWD/nushell $HOME/.config/nushell
    ln -sf $PWD/bashrc $HOME/.bashrc  
    ln -sf $PWD/profile $HOME/.profile
    ln -sf $PWD/nix $HOME/.config/nix
    ln -sf $PWD/ghostty $HOME/.config/ghostty
    ln -sf $PWD/hyprland/hypr $HOME/.config/hypr
    ln -sf $PWD/hyprland/swaync $HOME/.config/swaync
    ln -sf $PWD/themes $HOME/.config/themes
    ln -sf $PWD/hyprland/wal $HOME/.config/wal
    ln -sf $PWD/hyprland/waybar $HOME/.config/waybar
    ln -sf $PWD/hyprland/waypaper $HOME/.config/waypaper
    ln -sf $PWD/hyprland/wlogout $HOME/.config/wlogout
    ln -sf $PWD/hyprland/wofi $HOME/.config/wofi
    ln -sf $PWD/zed $HOME/.config/zed
    ln -sf $PWD/ssh/config $HOME/.ssh/config

    # Run nixos-rebuild
    echo "Downloading all packages and configuring the system..."
    sudo nixos-rebuild switch --flake $HOME/.config/nix --upgrade

    # Manage tpm (Tmux Plugin Manager)
    TPM_DIR="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$TPM_DIR" ]; then
        echo "Cloning tpm (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm.git "$TPM_DIR"
    else
        echo "tpm (Tmux Plugin Manager) already exists. Updating..."
        (cd "$TPM_DIR" && git pull)
    fi

    # Install/update tmux plugins
    echo "Installing/updating tmux plugins..."
    . "$TPM_DIR/scripts/install_plugins.sh"

    echo "Setup complete!"

# Setup for vps
elif [ "$ENV_TYPE" = "vps" ]; then
    echo "Running vps setup..."

    # Create the configuration foldes (if not present)
    echo "Creating configuration folders..."
    mkdir -p $HOME/.config
    mkdir -p $HOME/.ssh

    # Create the symbolic links with the configurations
    echo "Creating symbolic links..."
    ln -sf $PWD/starship/starship.toml $HOME/.config/starship.toml
    ln -sf $PWD/nvim $HOME/.config/nvim 
    ln -sf $PWD/tmux/tmux.conf $HOME/.tmux.conf
    ln -sf $PWD/nushell $HOME/.config/nushell
    ln -sf $PWD/bashrc $HOME/.bashrc  
    ln -sf $PWD/profile $HOME/.profile
    ln -sf $PWD/nix $HOME/.config/nix
    ln -sf $PWD/ssh/config $HOME/.ssh/config

    # Install home-manager CLI
    if ! command -v home-manager >/dev/null 2>&1; then
        echo -e "Installing home-manager CLI...\n"
        {
            nix profile install nixpkgs#home-manager
        } && echo -e "Home Manager CLI installed!\n" || {
            echo -e "An error occurred while trying to install Home Manager CLI!\n"
            exit 1
        }
    fi

    # Run home-manager
    echo "Downloading all packages and configuring the user ..."
    home-manager switch --flake $HOME/.config/nix --upgrade

    # Manage tpm (Tmux Plugin Manager)
    TPM_DIR="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$TPM_DIR" ]; then
        echo "Cloning tpm (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm.git "$TPM_DIR"
    else
        echo "tpm (Tmux Plugin Manager) already exists. Updating..."
        (cd "$TPM_DIR" && git pull)
    fi

    # Install/update tmux plugins
    echo "Installing/updating tmux plugins..."
    . "$TPM_DIR/scripts/install_plugins.sh"

    echo "Setup complete!"

else
    echo "Unknown environment. Skipping setup."
    exit 1
fi
