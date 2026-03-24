{ inputs, m, ... }:
{
  imports = [
    inputs.sops-nix.darwinModules.sops
    m.secrets
  ];
}
