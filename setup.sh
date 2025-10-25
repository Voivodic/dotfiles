#!/bin/bash

# Parse the command-line arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --env)
            if [ -n "$2" ]; then
                ENV_TYPE="$2"
                shift
            else
                echo -e "Error: --env requires an argument (personal or vps).\n"
                exit 1
            fi
            ;;
        *)
            echo -e "Unknown parameter passed: $1\n"
            exit 1
            ;;
    esac
    shift
done

# Check if curl is installed
if ! command -v curl >/dev/null 2>&1; then
     echo -e "curl is not installed! Please install curl to proceed.\n"
     exit 1
fi

# Check if the system is NixOS
if grep -q "ID=nixos" /etc/os-release 2>/dev/null; then
    echo -e "Running on NixOS. Skipping Nix installation and sourcing.\n"
else
    # Check if nix is already installed and sourced
    if [ -z "$NIX_GCROOT" ]; then
        # Install nix (multi-user)
        echo -e "Installing nix...\n"
        {
            sh <(curl -L https://nixos.org/nix/install) --no-daemon
        } && echo -e "Nix installed!\n" || {
            echo -e "An error occurred while trying to install nix!\n"
            exit 1
        }

        # Source the nix profile script
        echo -e "Sourcing nix profile...\n"
        {
            . $HOME/.nix-profile/etc/profile.d/nix.sh 
        } && echo -e "Nix sourced!\n" || {
            echo -e "An error occurred while trying to source nix!\n"
            exit 1
        }
    else
        echo -e "Nix is already installed and sourced. Skipping installation and sourcing.\n"
    fi
fi

# Setup for personal machine
if [ "$ENV_TYPE" = "personal" ]; then
    echo -e "Running personal setup...\n"

    # Create the configuration folders (if not present)
    echo -e "Creating configuration folders...\n"
    mkdir -p $HOME/.config
    mkdir -p $HOME/.ssh

    # Remove the existing directory with configurations
    echo -e "Removing existing configurations...\n"
    for dir in nushell nvim nix ghostty hypr swaync themes wal waybar waypaper wlogout wofi zed; do
        rm -rf $HOME/.config/$dir
    done

    # Create the symbolic links with the configurations
    echo -e "Creating symbolic links...\n"
    ln -sf $PWD/starship/starship.toml $HOME/.config
    ln -sf $PWD/tmux/tmux.conf $HOME/.tmux.conf
    ln -sf $PWD/bashrc $HOME/.bashrc  
    ln -sf $PWD/profile $HOME/.profile
    ln -sf $PWD/ssh/config $HOME/.ssh
    ln -s $PWD/nushell $HOME/.config
    ln -s $PWD/nvim $HOME/.config 
    ln -s $PWD/nix $HOME/.config
    ln -s $PWD/ghostty $HOME/.config
    ln -s $PWD/hyprland/hypr $HOME/.config
    ln -s $PWD/hyprland/swaync $HOME/.config
    ln -s $PWD/themes $HOME/.config
    ln -s $PWD/hyprland/wal $HOME/.config
    ln -s $PWD/hyprland/waybar $HOME/.config
    ln -s $PWD/hyprland/waypaper $HOME/.config
    ln -s $PWD/hyprland/wlogout $HOME/.config
    ln -s $PWD/hyprland/wofi $HOME/.config
    ln -s $PWD/zed $HOME/.config

    # Run nixos-rebuild
    echo -e "Downloading all packages and configuring the system...\n"
    sudo nixos-rebuild switch --flake $HOME/.config/nix --upgrade

    # Sourcing hyprland
    echo -e "Sourcing hyprland...\n"
    hyprctl reload

    # Manage tpm (Tmux Plugin Manager)
    TPM_DIR="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$TPM_DIR" ]; then
        echo -e "Cloning tpm (Tmux Plugin Manager)...\n"
        git clone https://github.com/tmux-plugins/tpm.git "$TPM_DIR"
    else
        echo -e "tpm (Tmux Plugin Manager) already exists. Updating...\n"
        (cd "$TPM_DIR" && git pull)
    fi

    # Install/update tmux plugins
    echo -e "Installing/updating tmux plugins...\n"
    . "$TPM_DIR/scripts/install_plugins.sh"

    echo -e "Setup complete!\n"

# Setup for vps
elif [ "$ENV_TYPE" = "vps" ]; then
    echo -e "Running vps setup...\n"

    # Create the configuration foldes (if not present)
    echo -e "Creating configuration folders...\n"
    mkdir -p $HOME/.config
    mkdir -p $HOME/.ssh

    # Remove the existing directory with configurations
    echo -e "Removing existing configurations...\n"
    for dir in nushell nvim nix; do
        rm -rf $HOME/.config/$dir
    done

    # Create the symbolic links with the configurations
    echo -e "Creating symbolic links...\n"
    ln -sf $PWD/starship/starship.toml $HOME/.config
    ln -sf $PWD/tmux/tmux.conf $HOME/.tmux.conf
    ln -sf $PWD/bashrc $HOME/.bashrc  
    ln -sf $PWD/profile $HOME/.profile
    ln -sf $PWD/ssh/config $HOME/.ssh
    ln -s $PWD/nushell $HOME/.config
    ln -s $PWD/nvim $HOME/.config
    ln -s $PWD/nix $HOME/.config

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
    echo -e "Downloading all packages and configuring the user ...\n"
    home-manager switch --flake $HOME/.config/nix --upgrade

    # Manage tpm (Tmux Plugin Manager)
    TPM_DIR="$HOME/.tmux/plugins/tpm"
    if [ ! -d "$TPM_DIR" ]; then
        echo -e "Cloning tpm (Tmux Plugin Manager)...\n"
        git clone https://github.com/tmux-plugins/tpm.git "$TPM_DIR"
    else
        echo -e "tpm (Tmux Plugin Manager) already exists. Updating...\n"
        (cd "$TPM_DIR" && git pull)
    fi

    # Install/update tmux plugins
    echo -e "Installing/updating tmux plugins...\n"
    . "$TPM_DIR/scripts/install_plugins.sh"

    echo -e "Setup complete!\n"

else
    echo -e "Unknown environment. Skipping setup.\n"
    exit 1
fi
