{
  description = "blazingly fast nix config";
  inputs = {
    # nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nix-darwin = {
      url = "https://flakehub.com/f/nix-darwin/nix-darwin/0.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kmonad.url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
  };
  outputs = {
    nixpkgs,
    determinate,
    nixos-hardware,
    home-manager,
    nix-darwin,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      formatter = pkgs.alejandra;
      devShells.default = pkgs.callPackage ./shell.nix {};
    })
    // (let
      lib = nixpkgs.lib // home-manager.lib // (import ./lib);
      specialArgs = {
        inherit inputs lib;
        modules = import ./modules;
      };
    in {
      nixosConfigurations.dreampad = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          determinate.nixosModules.default
          nixos-hardware.nixosModules.lenovo-thinkpad-t14-intel-gen6
          home-manager.nixosModules.home-manager
          ./hosts/linux/dreampad/configuration.nix
        ];
      };
      darwinConfigurations.powerlaptop = nix-darwin.lib.darwinSystem {
        inherit specialArgs;
        modules = [
          determinate.darwinModules.default
          home-manager.darwinModules.home-manager
          ./hosts/darwin/powerlaptop
        ];
        system = "aarch64-darwin";
      };
    });
}
