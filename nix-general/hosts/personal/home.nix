{ pkgs, username, ... }:

{
    # Import the common configurations
    imports = [ ../common-home.nix ];

    # Configurethe user
    home.username = username;
    home.homeDirectory = "/home/${username}";

    # List of pacckges for this system
    home.packages = with pkgs; [
        # Install latex
        texliveFull

        # Install sphinx for python documentation
        sphinx

        # Install LSPs
        ltex-ls-plus
        texlab
        # Formatters
        # Linters

        # LLM in terminal
        gemini-cli
        qwen-code
        opencode

        # For managing containers
        podman
        podman-compose
        apptainer
    ];
}
