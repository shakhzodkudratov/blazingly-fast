# imported in @/flake.nix
{
  nixpkgs,
  inputs,
  outputs,
  kmonad,
}:
{
  "dreampad" = nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [
      ./dreampad/configuration.nix
      kmonad.nixosModules.default
      ../dotfiles/astronvim.nix/nix/nixos.nix
    ];
  };
}
