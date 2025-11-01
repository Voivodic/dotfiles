# Set some env configurations
$env.config = {
    show_banner: false,
    render_right_prompt_on_last_line : true
}

# Set starship
use ~/.cache/starship/init.nu

# Set some aliases
alias nix-up = sudo nixos-rebuild switch --flake ~/.config/nix --upgrade
alias hm-up = home-manager switch --flake ~/.config/nix --upgrade
alias nix-clean = sudo nix-collect-garbage -d
alias pod-up = podman-compose up
alias pod-down = podman-compose down
# def cosmo [file] {apptainer exec ~/ImagesD/Cosmo/cosmo.sif python3 $file}

# Alias for zed
def zed [file] {zeditor $file}
