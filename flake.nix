{
  description = "My blazingly fast nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xmonad-contexts = {
      url = "github:Procrat/xmonad-contexts";
      flake = false;
    };
    kmonad = {
      url = "github:kmonad/kmonad?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Nix formatting pack
    # https://gerschtli.github.io/nix-formatter-pack/nix-formatter-pack-options.html
    nix-formatter-pack = {
      url = "github:Gerschtli/nix-formatter-pack";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      kmonad,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
    in
    {
      inherit lib;
      overlays = import ./common/overlays.nix { inherit inputs; };
      configurationModules = import ./common/configuration-modules;
      homeManagerModules = import ./common/home-manager;
      nixosConfigurations = import ./machines {
        inherit
          nixpkgs
          inputs
          outputs
          kmonad
          ;
      };
    };
}
