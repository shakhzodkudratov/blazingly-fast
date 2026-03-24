{ inputs, ... }:
{
  imports = [inputs.lix-module.darwinModules.default];
  system = {
    stateVersion = 6;
    primaryUser = "shakhzod";
  };

  nix = {
    enable = true;
    nixPath = [ ];
    extraOptions = ''
      extra-deprecated-features = or-as-identifier
    '';
  };
}
