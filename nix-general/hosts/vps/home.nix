{ pkgs, username, ... }:

{
    # Import the common configurations
    imports = [ ../common-home.nix ];

    # Configurethe user
    home.username = username;
    home.homeDirectory = "/home/${username}";

    # List of pacckges for this system
    home.packages = with pkgs; [
        # For managing containers
        podman
        podman-compose
        apptainer
    ];
}
