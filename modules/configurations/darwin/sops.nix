{ inputs, ... }:
{
  imports = [
    inputs.sops-nix.darwinModules.sops
    inputs.sops.module
  ];
}
