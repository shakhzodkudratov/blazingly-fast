{
  description = "My blazingly fast nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    nixpkgs-2311.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astronvim = {
      url = "github:AstroNvim/AstroNvim/v4.7.7";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-2311
    , nixpkgs-unstable
    , home-manager
    , flake-utils
    , ...
    } @ inputs:
    let
      inherit (self) outputs;

      lib = nixpkgs.lib // home-manager.lib;

      systems = [
        "x86_64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
    in
    {
      inherit lib;

      overlays = import ./overlays.nix { inherit inputs; };

      nixosConfigurations = import ./machines { inherit nixpkgs inputs outputs; };

      homeManagerModules = import ./home-manager;
      homeConfigurations = {
        "shakhzod@workpc" = home-manager.lib.homeManagerConfiguraiton {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./global/home.nix
          ];
        };
      };
    };
}
