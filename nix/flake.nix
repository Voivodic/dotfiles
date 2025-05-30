{
    description = "Voivodic's NixOS Flake Configuration";

    inputs = {
        # Define your nixpkgs input, e.g., stable channel
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # Or your preferred stable branch like nixos-23.11

        # Define your unstable nixpkgs input
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

        # If you plan to use Home Manager as a Flake, you'd add it here:
        # home-manager.url = "github:nix-community/home-manager";
        # home-manager.inputs.nixpkgs.follows = "nixpkgs"; # Ensures HM uses the same nixpkgs
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
        let
            system = "x86_64-linux"; # Adjust if you have a different architecture

            # Create a pkgs instance from nixpkgs-unstable, inheriting the system architecture
            # and ensuring unfree packages are allowed for this specific package set.
            unstablePkgs = import inputs.nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true; # Allow unfree for packages from this specific input
            };
        in
            {
            nixosConfigurations = {
                # The hostname "nixos" here should match networking.hostName in your configuration.nix
                # This is the name you'll use when building, e.g., .#nixos
                nixos = nixpkgs.lib.nixosSystem {
                    inherit system;
                    specialArgs = {
                        # Pass the unstable package set to your configuration modules
                        inherit unstablePkgs;
                        # You can pass other inputs or custom arguments here if needed
                        # e.g., home-manager = inputs.home-manager;
                    };
                    modules = [
                        # Your main configuration file
                        /etc/nixos/configuration.nix

                        # If you were using Home Manager, you would add its NixOS module:
                        # inputs.home-manager.nixosModules.home-manager
                        # {
                        #   home-manager.useGlobalPkgs = true;
                        #   home-manager.useUserPackages = true;
                        #   # Pass unstablePkgs to home-manager configurations if needed
                        #   home-manager.extraSpecialArgs = { inherit unstablePkgs; };
                        #   home-manager.users.voivodic = import ./home.nix; # Path to your home.nix
                        # }
                    ];
                };
            };
        };
}
