{ inputs, modules, ... }:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
    modules.secrets
  ];
}
