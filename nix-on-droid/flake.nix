{
  description = "Advanced example of Nix-on-Droid system config with home-manager.";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # Temporary workaround for https://github.com/nix-community/nix-on-droid/issues/10/495
    nixpkgs.url = "github:NixOS/nixpkgs/88d3861";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-on-droid }: {

    nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
      modules = [
        ./nix-on-droid.nix
      ];

      # list of extra special args for Nix-on-Droid modules
      extraSpecialArgs = {
        # rootPath = ./.;
      };

      # set nixpkgs instance, it is recommended to apply `nix-on-droid.overlays.default`
      pkgs = import nixpkgs {
        system = "aarch64-linux";

        overlays = [
          nix-on-droid.overlays.default
        ];
      };

      # set path to home-manager flake
      home-manager-path = home-manager.outPath;
    };

  };
}
