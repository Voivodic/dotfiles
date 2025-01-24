#!/bin/bash

# Check if some basic libraries are installed
for pkg in wget curl git; do
    if ! dpkg -s $pkg >/dev/null 2>&1; then
         echo "$pkg is not installed!\n"
    fi
done

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
    . /etc/profile.d/nix.sh
} && echo -e "Nix sourced!\n" || {
    echo -e "An error ocurred while trying to source nix!\n"
    exit 1
}

# Install all packages using nix
echo -e "Installing all packages with nix...\n"
{
    nix-env -iA nixpkgs.nerd-fonts.hack
    nix-env -iA nixpkgs.nushell
    nix-env -iA nixpkgs.fzf
    nix-env -iA nixpkgs.tmux
    nix-env -iA nixpkgs.neovim
    nix-env -iA nixpkgs.starship
    nix-env -iA nixpkgs.python314
    nix-env -iA nixpkgs.libgcc
    nix-env -iA nixpkgs.zig
} && echo -e "All files correctly installed!\n" || {
    echo -e "An error ocurred while trying to install packages!\n"
    exit 1
}
