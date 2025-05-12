# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz") { config.allowUnfree = true; }; 
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networkManager to manage the network connections
  networking.networkmanager.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
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

  # Enable hyperland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  # Extra configurations for hyprland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
  };
  #security.pam.services.hyprlock = {};

  # Set the nvidia GPU
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    # Configuration taken from nixos website
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Options to set how to change between GPU and CPU's graphics
  hardware.nvidia.prime = {
    # Set the to change between the gpus
    sync.enable = true;

    # BUS ID for the cpu's GPU and the nvidia's GPU
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:43:0:0";
  };

  #XDG portal
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # For starting the graphical interface directly
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "Hyprland";
        user = "voivodic";
      };
      default_session = {
        command = "Hyprland";
        user = "voivodic";
      };
    };
  };

  # For mounting USB devices
  services.gvfs.enable = true; 
  services.udisks2.enable = true;

  # Enable sound with pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable bluetooth
  hardware.bluetooth.enable = true; 
  hardware.bluetooth.powerOnBoot = true; 
  services.blueman.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable steam
  programs.steam.enable = true;

  # Enable appimages
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.voivodic = {
    isNormalUser = true;
    description = "Voivodic";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.nushell;
    packages = with pkgs; [
      # Install the main packages
      unstable.neovim
      unstable.nushell
      fzf
      unzip
      sshfs
      unstable.tmux
      unstable.starship

      # Install some languages
      unstable.python313
      unstable.gcc
      unstable.zig
      unstable.rustup
      unstable.texliveFull

      # Install LSPs
      unstable.python313Packages.python-lsp-server
      unstable.clang-tools
      unstable.zls
      unstable.nixd
      unstable.texlab
      unstable.ltex-ls
      # Formatters
      unstable.isort
      unstable.black
      # Linters
      unstable.pylint
      unstable.cppcheck
      unstable.codespell

      # Ollama for running LLMs
      unstable.ollama

      # Install some extra packages
      spotify
      zoom-us

      # Stuff for games
      godot_4
      glfw
      bottles

      # For managing containers
      podman

      # For showing information about the system 
      neofetch
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Some useful CLIs
    git
    wget
    curl
    htop
    lshw
    gnumake
    cmake

    # Wayland
    hyprland
    xwayland

    # For vulkan
    libGL
    pkgs.mesa
    pkgs.vulkan-loader
    pkgs.vulkan-tools
    pkgs.vulkan-validation-layers

    # Cursor
    hyprcursor

    # Screen-shots
    hyprshot

    # Status bar
    waybar
    hyprpicker
    blueman
    bluez
    networkmanager
    swaynotificationcenter

    # Notifications
    #swaynotificationcenter
    #pywal
    gvfs
    libnotify

    # Lock screen
    hyprlock
    hypridle
    greetd.greetd

    # Logout menu
    wlogout

    # Wallpaper
    swww
    waypaper
    jq

    # Terminal
    ghostty

    # Launcher
    wofi 

    # Browser
    microsoft-edge

    # Network management tool
    #networkmanager
    networkmanagerapplet

    # For managing usb devices
    usermount
    gvfs
    ntfs3g

    # File manager
    ueberzugpp
    yazi

    # PDF viewer and note taking
    zathura 
    xournalpp
  ];

  # Enable fonts and set them
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerdfonts
    font-awesome
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # Some overlay configs
  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs : {
        masonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
}
