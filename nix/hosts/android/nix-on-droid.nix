{ config, lib, pkgs, inputs, username, ... }:

{
    # Backup etc files instead of failing to activate generation if a file already exists in /etc
    environment.etcBackupExtension = ".bak";

    # Read the changelog before changing this value
    system.stateVersion = "24.05";

    # Set up nix for flakes
    nix.extraOptions = ''
    experimental-features = nix-command flakes
    '';

    # Set your time zone
    time.timeZone = "America/Chicago";

    # Configure home-manager
    home-manager = {
        config = ./home.nix;
        extraSpecialArgs = { inherit inputs username; };
        backupFileExtension = "hm-bak";
        useGlobalPkgs = true;
    };
}
