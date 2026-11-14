{
    description = "Voivodic's Unified Multi-Machine Configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        
        lanzaboote = {
            url = "github:nix-community/lanzaboote/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, lanzaboote, ... }@inputs:
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
            mkHome_x86_64 = hostName: home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages."x86_64-linux";
                extraSpecialArgs = { inherit inputs username; };
                modules = [ ./hosts/${hostName}/home.nix ];
            };

            # Shared helper for home-manager (aarch64)
            mkHome_aarch64 = hostName: home-manager.lib.homeManagerConfiguration {
                pkgs = nixpkgs.legacyPackages."aarch64-linux";
                extraSpecialArgs = { inherit inputs username; };
                modules = [ ./hosts/${hostName}/home.nix ];
            };
        in {
            # Configure NixOs hosts
            # Usage: nixos-rebuild switch --flake .#hostName
            nixosConfigurations = {
                personal = mkNixos "personal";
                vps = mkNixos "vps";
                termux = mkNixos "termux";
            };

            # Standalone Home Manager for portability
            # Usage: home-manager switch --flake .#hostName
            homeConfigurations = {
                personal = mkHome_x86_64 "personal";
                vps = mkHome_x86_64 "vps";
                termux = mkHome_aarch64 "termux";
            };
        };
}

