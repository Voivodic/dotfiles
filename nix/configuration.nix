{ config, pkgs, ... }:

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
        cores = 4;
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
        trusted-users = [ "root" "voivodic" ];
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    time.timeZone = "America/Sao_Paulo";

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


    # Define a user account.
    users.users.voivodic = {
        isNormalUser = true;
        description = "Voivodic";
        extraGroups = [ "networkmanager" "wheel" ];
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
        greetd

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

        # PNG viwer
        swayimg

        # Install some extra packages
        spotify
        zoom-us

        # Stuff for games
        godot_4
        glfw
        bottles
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
