{ inputs, modules, ... }:
{
  imports = [
    inputs.sops-nix.darwinModules.sops
    modules.secrets
  ];
}
