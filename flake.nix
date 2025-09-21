{
  description = "blazingly fast nix config";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
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
    nixpkgs,
    flake-utils,
    nixos-hardware,
    nur,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [nur.overlays.default];
      };
    in {
      formatter = pkgs.alejandra;
      devShells = {
        default = with pkgs;
          mkShell {
            nativeBuildInputs = with pkgs; [
              nixd
              deadnix
              statix
              alejandra
              git
            ];
            shellHook = ''
              export EDITOR=nvim
            '';
          };
      };
    })
    // (let
      lib = nixpkgs.lib // home-manager.lib // (import ./lib);
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
      nixosConfigurations.dreampad = nixpkgs.lib.nixosSystem {
        specialArgs = specialArgs {
          flags.plasma.enable = true;
        };
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-t14-intel-gen6
          home-manager.nixosModules.home-manager
          ./hosts/linux/dreampad/configuration.nix
        ];
      };
    });
}
