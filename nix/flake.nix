{
    description = "Voivodic's Unified Multi-Machine Configuration";

    inputs = {
        # Using the specific commit for nix-on-droid compatibility #
        nixpkgs-android.url = "github:nixos/nixpkgs/88d3861";
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager-android = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs-android";
        };


        lanzaboote = {
            url = "github:nix-community/lanzaboote/v0.4.3";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-on-droid = {
            url = "github:nix-community/nix-on-droid";
            inputs.nixpkgs.follows = "nixpkgs-android";
            inputs.home-manager.follows = "home-manager-android";
        };
    };

    outputs = { self, nixpkgs, nixpkgs-android, home-manager, home-manager-android, lanzaboote, nix-on-droid, ... }@inputs:
        let
            username = "voivodic";

            # Shared helper for NixOS (x86_64)
            mkNixos = hostName: nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs username; };
                modules = [
                    ./hosts/${hostName}/configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.${username} = ./hosts/${hostName}/home.nix;
                        home-manager.extraSpecialArgs = { inherit inputs username; };
                    }
                    lanzaboote.nixosModules.lanzaboote
                ];
            };

            # Shared helper for home-manager (x86_64)
            mkHome = hostName: home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages."x86_64-linux";
                extraSpecialArgs = { inherit inputs username; };
                modules = [ ./hosts/${hostName}/home.nix ];
            };
        in {
            # Configure NixOs hosts
            # Usage: nixos-rebuild switch --flake .#hostName
            nixosConfigurations = {
                personal = mkNixos "personal";
                vps = mkNixos "vps";
            };

            # Configure Android hosts
            # Usage: nix-on-droid switch --flake .#android
            nixOnDroidConfigurations.android = nix-on-droid.lib.nixOnDroidConfiguration {
                pkgs = import nixpkgs-android {
                    system = "aarch64-linux";
                    overlays = [ nix-on-droid.overlays.default ];
                };
                extraSpecialArgs = { inherit inputs username; };
                modules = [ 
                    ./hosts/android/nix-on-droid.nix 
                ];
            };

            # Standalone Home Manager for portability
            # Usage: home-manager switch --flake .#hostName
            homeConfigurations = {
                personal = mkHome "personal";
                vps = mkHome "vps";
            };
        };
}

