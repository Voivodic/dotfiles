# Set some env configurations
$env.config = {
    show_banner: false,
    render_right_prompt_on_last_line : true
}

# Set starship
use ~/.cache/starship/init.nu

# Set some aliases
alias nix-update = nix flake update --flake ~/.config/nix
alias nix-upgrade = sudo nixos-rebuild switch --flake ~/.config/nix#nixos
alias nix-on-droid-upgrade = nix-on-droid switch --flake ~/.config/nix
alias hm-upgrade = home-manager switch --flake ~/.config/nix#voivodic
alias nix-clean = sudo nix-collect-garbage -d
alias nix-on-droid-clean = nix-collect-garbage -d
alias pod-up = podman-compose up
alias pod-down = podman-compose down
# def cosmo [file] {apptainer exec ~/ImagesD/Cosmo/cosmo.sif python3 $file}

# Alias for zed
def zed [file] {zeditor $file}
