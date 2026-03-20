{ pkgs, username, ... }:

{
    # Import the common configurations
    imports = [ ../common-home.nix ];

    # Configurethe user
    home.username = username;
    home.homeDirectory = "/home/${username}";

    # List of pacckges for this system
    home.packages = with pkgs; [
        # LLM in terminal
        gemini-cli
        qwen-code
        opencode
    ];
}
