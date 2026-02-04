{ config, pkgs, lib, ... }:

{
    imports = [ ./hardware-configuration.nix ];

    # Format of the text
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
   
    nix.settings = {
        max-jobs = 1;
        cores = 16;
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
        trusted-users = [ "root" "voivodic" ];
    };

    # Used to recognize the keyboard
    boot.kernelModules = [ "ideapad_laptop" ];

    # For the bootloader
    #boot.loader.systemd-boot.enable = false;
    boot.loader.efi.canTouchEfiVariables = true;

    # For the secure boot
    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
    };

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    time.timeZone = "America/Chicago";

    # Enable hyperland
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
    };

    # Set the default browser
    environment.variables.BROWSER = "microsoft-edge";

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
        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.latest;
    };

    # Options to set how to change between GPU and CPU's graphics
    hardware.nvidia.prime = {
        # Set the to change between the gpus
        sync.enable = false;

        # Enable Offload Mode for manually managing the GPU
        offload = {
            enable = true;
            enableOffloadCmd = true; # Provides the 'nvidia-offload' command
        };

        # BUS ID for the cpu's GPU and the nvidia's GPU
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:2:0:0";
    };

    # Enable gamemode for better performance
    programs.gamemode.enable = true;

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

    # Adjust the mouse sensitivity
    services.libinput.enable = true;
    services.libinput.mouse.accelProfile = "flat"; # Disable acceleration
    services.libinput.mouse.accelSpeed = -0.9; # Adjust sensitivity

    # Enable sound with pipewire
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
    };

    # Enable ssh access from tablet/cellphone
    services.tailscale = {
        enable = true;
        useRoutingFeatures = "client";
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

    # Enable appimages
    programs.appimage.enable = true;
    programs.appimage.binfmt = true;


    # Define a user account.
    users.users.voivodic = {
        isNormalUser = true;
        description = "Voivodic";
        extraGroups = [ "networkmanager" "wheel" "gamemode" ];
        # The shell is now managed by Home Manager, but it's good to have a fallback.
        shell = pkgs.nushell;
        # REMOVED: The entire 'packages' list has been moved to home.nix
    };

    # List of SYSTEM WIDE packages.
    # These are tools needed for the system to function correctly.
    environment.systemPackages = with pkgs; [
        # Wayland
        hyprland
        xwayland

        # For input devices
        libinput
        lm_sensors

        # For generation of keys for secure boot
        sbctl

        # For vulkan
        libGL
        mesa
        vulkan-loader
        vulkan-tools
        vulkan-validation-layers

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
        greetd

        # Logout menu
        wlogout

        # Wallpaper
        swww
        waypaper
        jq

        # Control the screen brightness
        brightnessctl

        # Terminal
        ghostty

        # Zed editor
        zed-editor

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

        # PNG viwer
        swayimg

        # Install some extra packages
        spotify
        zoom-us

        # Cuda for GPU acceleration
        cudaPackages.cudatoolkit
        cudaPackages.cudnn

        # Stuff for games
        godot_4
        glfw
        bottles

        # Lllama.cpp for local LLMs
        (llama-cpp.override { cudaSupport = true; })
    ];

    # Set the fonts
    fonts.packages = with pkgs; [
        nerd-fonts.droid-sans-mono
        font-awesome
    ];

    # ... (keep fonts, services, stateVersion, etc.)
    services.openssh.enable = true;
    system.stateVersion = "25.05";
    nixpkgs.overlays = [
        (self: super: {
            waybar = super.waybar.overrideAttrs (oldAttrs: {
                mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
            });
        })
    ];
}
