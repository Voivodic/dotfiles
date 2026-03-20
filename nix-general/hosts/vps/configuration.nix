{ config, pkgs, lib, ... }:

{
    # Format of the text
    i18n.defaultLocale = "en_US.UTF-8"; 
    i18n.extraLocaleSettings = { 
        LC_ADDRESS = "es_ES.UTF-8";
        LC_IDENTIFICATION = "es_ES.UTF-8"; 
        LC_MEASUREMENT = "es_ES.UTF-8"; 
        LC_MONETARY = "es_ES.UTF-8"; 
        LC_NAME = "es_ES.UTF-8"; 
        LC_NUMERIC = "es_ES.UTF-8"; 
        LC_PAPER = "es_ES.UTF-8"; 
        LC_TELEPHONE = "es_ES.UTF-8"; 
        LC_TIME = "es_ES.UTF-8"; 
    };
   
    nix.settings = {
        max-jobs = 1;
        cores = 1;
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
        trusted-users = [ "root" "voivodic" ];
    };

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "br";
        variant = "nodeadkeys";
    };

    # Configure console keymap
    console.keyMap = "br-abnt2";

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Define a user account.
    users.users.voivodic = {
        isNormalUser = true;
        description = "Voivodic";
        extraGroups = [ "networkmanager" "wheel" ];
        # The shell is now managed by Home Manager, but it's good to have a fallback.
        shell = pkgs.nushell;
        # REMOVED: The entire 'packages' list has been moved to home.nix
    };

    # List of SYSTEM WIDE packages.
    # These are tools needed for the system to function correctly.
    environment.systemPackages = with pkgs; [
        # File manager
        ueberzugpp
        yazi
    ];

    # Set the fonts
    fonts.packages = with pkgs; [
        nerd-fonts.droid-sans-mono
        font-awesome
    ];

    # ... (keep fonts, services, stateVersion, etc.)
    services.openssh.enable = true;
    system.stateVersion = "25.05";
    nixpkgs.overlays = [
        (self: super: {
            waybar = super.waybar.overrideAttrs (oldAttrs: {
                mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
            });
        })
    ];
}
