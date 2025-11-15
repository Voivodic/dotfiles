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

# Setup for personal machine
if [ "$ENV_TYPE" = "personal" ]; then
    echo -e "Running personal setup...\n"

    # Create the configuration folders (if not present)
    echo -e "Creating configuration folders...\n"
    mkdir -p $HOME/.config
    mkdir -p $HOME/.ssh
    mkdir -p $HOME/.gemini
    mkdir -p $HOME/.qwen
    mkdir -p $HOME/.config/opencode

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
    ln -sf $PWD/agents/qwen/settings.json $HOME/.qwen/settings.json
    ln -sf $PWD/agents/gemini/settings.json $HOME/.gemini/settings.json
    ln -sf $PWD/agents/opencode/config.json $HOME/.config/opencode/config.json
    for dir in nushell nvim nix ghostty hyprland/hypr hyprland/swaync themes hyprland/wal hyprland/waybar hyprland/waypaper hyprland/wlogout hyprland/wofi zed; do
        ln -s $PWD/$dir $HOME/.config
    done

    # Run nixos-rebuild
    echo -e "Downloading all packages and configuring the system...\n"
    sudo nixos-rebuild switch --flake $HOME/.config/nix#nixos

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

    # Create the configuration foldes (if not present)
    echo -e "Creating configuration folders...\n"
    mkdir -p $HOME/.config
    mkdir -p $HOME/.ssh
    mkdir -p $HOME/.gemini
    mkdir -p $HOME/.qwen
    mkdir -p $HOME/.config/opencode

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
    ln -sf $PWD/agents/qwen/settings.json $HOME/.qwen/settings.json
    ln -sf $PWD/agents/gemini/settings.json $HOME/.gemini/settings.json
    ln -sf $PWD/agents/opencode/config.json $HOME/.config/opencode/config.json
    for dir in nushell nvim nix; do
        ln -s $PWD/$dir $HOME/.config
    done

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
    home-manager switch --flake $HOME/.config/nix#voivodic

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

# Setup for termux using nix-on-droid
elif [ "$ENV_TYPE" = "termux" ]; then
    echo -e "Running termus setup...\n"

    # Create the configuration foldes (if not present)
    echo -e "Creating configuration folders...\n"
    mkdir -p $HOME/.config
    mkdir -p $HOME/.ssh
    mkdir -p $HOME/.gemini
    mkdir -p $HOME/.qwen
    mkdir -p $HOME/.config/opencode

    # Remove the existing directory with configurations
    echo -e "Removing existing configurations...\n"
    for dir in nushell nvim; do
        rm -rf $HOME/.config/$dir
    done

    # Create the symbolic links with the configurations
    echo -e "Creating symbolic links...\n"
    ln -sf $PWD/starship/starship.toml $HOME/.config
    ln -sf $PWD/tmux/tmux.conf $HOME/.tmux.conf
    ln -sf $PWD/bashrc $HOME/.bashrc  
    ln -sf $PWD/profile $HOME/.profile
    ln -sf $PWD/ssh/config $HOME/.ssh 
    ln -sf $PWD/nix/home.nix $HOME/.config/nix-on-droid
    ln -sf $PWD/agents/qwen/settings.json $HOME/.qwen/settings.json
    ln -sf $PWD/agents/gemini/settings.json $HOME/.gemini/settings.json
    ln -sf $PWD/agents/opencode/config.json $HOME/.config/opencode/config.json
    for dir in nushell nvim; do
        ln -s $PWD/$dir $HOME/.config
    done

    # Run nix-on-droid
    echo -e "Downloading all packages and configuring the user ...\n"
    nix-on-droid switch --flake $HOME/.config/nix-on-droid#.

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
