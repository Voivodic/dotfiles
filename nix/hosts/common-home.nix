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
        zip
        unzip
        gawk
        openssh

        # Extra CLIs
        zoxide
        ripgrep
        fd
        fzf

        # Install the main packages
        neovim
        nushell
        sshfs
        tmux
        starship
        tree

        # Install some languages
        python314
        uv
        gcc
        zig
        go
        rustup
        rustc
        nodejs

        # Install LSPs
        python314Packages.python-lsp-server
        ruff
        clang-tools
        zls
        gopls
        nixd
        # Formatters
        # Linters
        cppcheck
        codespell
        rstcheckWithSphinx
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
            init.defaultBranch = "main";
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
            "containers-storage": {
                "": [
                    { "type": "insecureAcceptAnything" }
                ]
            },
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
