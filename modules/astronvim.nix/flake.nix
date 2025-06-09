{
  description = "astronvim.nix";
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = _: {
    nixosModules = rec {
      astronvim-nix = import ./nix/nixos.nix;
      default = astronvim-nix;
    };
    darwinModules = {
      astroNvim = import ./nix/darwin.nix;
      default = astronvim-nix;
    };
  };
}
