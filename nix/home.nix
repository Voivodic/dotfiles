{ pkgs, mcp-hub, ... }:

{
    # Home Manager needs to know your username and home directory.
    home.username = "voivodic";
    home.homeDirectory = "/home/voivodic";

    # This is the list of packages you want to install FOR YOUR USER.
    # We are moving this from your old configuration.nix
    home.packages = with pkgs; [
        # Install the main packages
        neovim
        nushell
        fzf
        unzip
        sshfs
        tmux
        starship
        tree
        zed-editor

        # Install some languages
        python313
        uv
        gcc
        zig
        rustup
        texliveFull
        nodejs

        # Install sphinx for python documentation
        sphinx

        # Install LSPs
        python313Packages.python-lsp-server
        ruff
        clang-tools
        zls
        nixd
        ltex-ls-plus
        texlab
        # Formatters
        # Linters
        cppcheck
        codespell
        rstcheckWithSphinx

        # Ollama for running LLMs
        ollama

        # Install mcp-hub (passed from the flake)
        mcp-hub.packages.x86_64-linux.mcp-hub

        # Install some extra packages
        spotify
        zoom-us

        # Stuff for games
        godot_4
        glfw
        bottles

        # LLM in terminal
        gemini-cli
        qwen-code
        crush

        # For managing containers
        podman
        podman-compose
        apptainer

        # For showing information about the system
        neofetch
    ];

    # Let Home Manager manage itself
    programs.home-manager.enable = true;

    # Set your default shell
    programs.nushell.enable = true;

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    home.stateVersion = "24.05"; # Set to the version you are currently using
}
