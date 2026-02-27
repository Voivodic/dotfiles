{ pkgs, ... }:

{
    # This is the list of packages you want to install FOR YOUR USER.
    # We are moving this from your old configuration.nix
    home.packages = with pkgs; [
        # Some useful CLIs
        git
        wget
        curl
        htop
        nvitop
        lshw
        gnumake
        cmake
        gnused
        gnutar
        gnugrep
        gzip
        gawk
        openssh

        # Install the main packages
        neovim
        nushell
        fzf
        unzip
        sshfs
        tmux
        starship
        tree

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
        gopls
        nixd
        ltex-ls-plus
        texlab
        # Formatters
        # Linters
        cppcheck
        codespell
        rstcheckWithSphinx

        # LLM in terminal
        gemini-cli
        qwen-code
        opencode

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

    # Set some aliases for git
    programs.git = {
        enable = true;

        settings = {
            user.name = "Voivodic";
            user.email = "rodrigo.voivodic@gmail.com";
            alias = {
                co = "checkout";
                br = "branch";
                ci = "commit";
                st = "status";
                hist = "log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short";
            };
        };
    };

    # Enable the fonts
    fonts.fontconfig.enable = true;

    # Enable pullingn images from Docker Hub
    home.file.".config/containers/policy.json".text = ''
        {
          "default": [
            { "type": "reject" }
          ],
          "transports": {
            "docker": {
              "docker.io": [
                { "type": "insecureAcceptAnything" }
              ]
            }
          }
        }
    '';

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    home.stateVersion = "24.05"; # Set to the version you are currently using
}
