{
  description = "astronvim.nix";
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
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
  };
}
