{ inputs, ... }:
{
  imports = [ inputs.lix-module.darwinModules.default ];

  nix = {
    enable = true;
    nixPath = [ ];
    extraOptions = ''
      extra-experimental-features = nix-command flakes
      extra-deprecated-features = or-as-identifier
    '';
  };
}
