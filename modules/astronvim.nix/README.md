# astronvim.nix

This is an implementation of the [AstroNvim](https://astronvim.com/)
configuration/plugin distribution for Neovim using Nix flakes. The flake contains both a
NixOS and NixDarwin module which allows for easy adaptation and installation. The flake
is not intended to be highly configurable, it was instead designed to allow me to easily
port my highly configured Neovim setup to other machines.

Forked from [SumAstroNvim](https://github.com/sum-rock/SumAstroNvim/).

## Installation

A very minimal installation in a typical nix flake would look as follows:

`flake.nix`

```nix
{
  description = "My NixOS configuration";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-24.11";
    };
    astronvim-nix = {
      url = "github:shakhzodkudratov/astronvim.nix/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, astronvim-nix }:
  {
    nixosConfigurations = {
      "my-hostname" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          astronvim-nix.nixosModules.astroNvim
        ];
      };
    };
  };
}
```

`configuration.nix`

```nix
{ config, pkgs, ...}:
{
  AstroNvim = {
    username = "shakhzod";
    nerdfont = "FiraCode";
    nodePackage = pkgs.nodejs;
    pythonPackage = pkgs.python311Full;
  };

  # Everything else required to configure your machine...
}
```
