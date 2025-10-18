{
    description = "Voivodic's NixOS Configuration";

    inputs = {
        # Nix Packages collection
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        # Home Manager
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        # Your mcp-hub dependency
        mcp-hub.url = "github:ravitemer/mcp-hub";
    };

    outputs = { self, nixpkgs, home-manager, mcp-hub, ... }: {
        # The NixOS configuration for your current machine
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit mcp-hub; }; # Pass mcp-hub to configuration.nix
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.voivodic = import ./home.nix;
                }
            ];
        };

        # The standalone Home Manager configuration for portability
        # You will use this on Arch Linux or other distros
        homeConfigurations.voivodic = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = { inherit mcp-hub; }; # Pass mcp-hub to home.nix
            modules = [ ./home.nix ];
        };
    };
}
