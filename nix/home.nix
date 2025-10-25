{ pkgs, ... }:

{
    # Format of the text
    home.sessionVariables = {
        LANG = "en_US.UTF-8";
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

    # This is the list of packages you want to install FOR YOUR USER.
    # We are moving this from your old configuration.nix
    home.packages = with pkgs; [
         # Some useful CLIs
        git
        wget
        curl
        htop
        lshw
        gnumake
        cmake
        lm_sensors

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
        go
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

        # The fonts used
        nerd-fonts.droid-sans-mono
        font-awesome
    ];

    # Let Home Manager manage itself
    programs.home-manager.enable = true;

    # Set your default shell
    programs.nushell.enable = true;

    # Enable the fonts
    fonts.fontconfig.enable = true;


    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    home.stateVersion = "24.05"; # Set to the version you are currently using
}
