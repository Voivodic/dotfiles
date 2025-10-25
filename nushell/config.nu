# Set some env configurations
$env.config = {
    show_banner: false,
    render_right_prompt_on_last_line : true
}

# Set starship
use ~/.cache/starship/init.nu

# Set some aliases
alias nixup = nixos-rebuild switch --flake ~/.config/nix --upgrade
alias hmup = home-manager switch --flake ~/.config/nix --upgrade
# def cosmo [file] {apptainer exec ~/ImagesD/Cosmo/cosmo.sif python3 $file}

# Alias for zed
def zed [file] {zeditor $file}
