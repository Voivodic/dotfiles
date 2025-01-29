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
    . $HOME/.nix-profile/etc/profile.d/nix.sh 
} && echo -e "Nix sourced!\n" || {
    echo -e "An error ocurred while trying to source nix!\n"
    exit 1
}

# Install all packages using nix
echo -e "Installing all packages with nix...\n"
{
    flags="--extra-experimental-features nix-command --extra-experimental-features flakes"

    # Install the main packages
    nix profile install nixpkgs#nerd-fonts.hack $flags
    nix profile install nixpkgs#nushell $flags
    nix profile install nixpkgs#fzf $flags
    nix profile install nixpkgs#tmux $flags
    nix profile install nixpkgs#neovim $flags
    nix profile install nixpkgs#starship $flags

    # Install some languages
    nix profile install nixpkgs#python312 $flags
    nix profile install nixpkgs#gcc14 $flags
    nix profile install nixpkgs#zig_0_13 $flags

    # Install the lsp for the languages
    nix profile install nixpkgs#python312Packages.python-lsp-server $flags
    nix profile install nixpkgs#python312Packages.black $flags
    nix profile install nixpkgs#zls $flags

} && echo -e "All files correctly installed!\n" || {
    echo -e "An error ocurred while trying to install packages!\n"
    exit 1
}
