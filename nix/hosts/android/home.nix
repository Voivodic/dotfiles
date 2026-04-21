{ lib, pkgs, username, ... }:

{
    # Import the common configurations
    imports = [ ../common-home.nix ];

    # Configurethe user
    home.username = "nix-on-droid";
    home.homeDirectory = "/data/data/com.termux.nix/files/home";

    # List of pacckges for this system
    home.packages = with pkgs; [
        # LLM in terminal
        gemini-cli
        qwen-code
        # opencode
    ];
}
