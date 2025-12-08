{
    description = "Voivodic's NixOS Configuration";

    inputs = {
        # Nix Packages collection
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        # Home Manager
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # Lanzaboote for setting up the secure boot
        lanzaboote.url = "github:nix-community/lanzaboote/v0.4.3";
        lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, lanzaboote, ... }: 
        let
            username = "voivodic";
        in {
            # The NixOS configuration for your current machine
            nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.voivodic = import ./home.nix;
                    }
                    lanzaboote.nixosModules.lanzaboote
                ];
            };

            # The standalone Home Manager configuration for portability
            # You will use this on Arch Linux or other distros

            homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages.x86_64-linux;
                modules = [ 
                    { 
                        home.username = username; 
                        home.homeDirectory = "/home/${username}";
                    } # Pass the username explicitly
                    ./home.nix
                ];
            };
        };
}
