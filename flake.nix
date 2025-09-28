{
  description = "blazingly fast nix config";
  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
  };
  outputs = {
    home-manager,
    nixpkgs-unstable,
    flake-utils,
    nixos-hardware,
    determinate,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs-unstable {
        inherit system;
      };
    in {
      formatter = pkgs.alejandra;
      devShells.default = pkgs.callPackage ./shell.nix {};
    })
    // (let
      lib = nixpkgs-unstable.lib // home-manager.lib // (import ./lib);
      _specialArgs = {
        inherit inputs lib;
        modules = import ./modules;
        flags = {
          plasma.enable = false;
          niri.enable = false;
        };
      };
      specialArgs = extraArgs: lib.recursiveUpdate _specialArgs extraArgs;
    in {
      nixosConfigurations.dreampad = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = specialArgs {
          flags.plasma.enable = true;
        };
        modules = [
          determinate.nixosModules.default
          nixos-hardware.nixosModules.lenovo-thinkpad-t14-intel-gen6
          home-manager.nixosModules.home-manager
          ./hosts/linux/dreampad/configuration.nix
        ];
      };
    });
}
