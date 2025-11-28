{
  description = "blazingly fast nix config";
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/*";
    nixpkgs-unstable.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    darwin = {
      url = "https://flakehub.com/f/nix-darwin/nix-darwin/0";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
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
    kmonad.url = "git+https://github.com/kmonad/kmonad?submodules=1&dir=nix";
  };
  outputs = {
    nixpkgs-unstable,
    determinate,
    nixos-hardware,
    home-manager,
    darwin,
    flake-utils,
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
      specialArgs = {
        inherit inputs lib;
        modules = import ./modules;
      };
    in {
      nixosConfigurations.dreampad = nixpkgs-unstable.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          determinate.nixosModules.default
          nixos-hardware.nixosModules.lenovo-thinkpad-t14-intel-gen6
          home-manager.nixosModules.home-manager
          ./hosts/linux/dreampad/configuration.nix
        ];
      };
      darwinConfigurations.powerlaptop = darwin.lib.darwinSystem {
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
