{ inputs, ... }:
{
  imports = [
    inputs.lix-module.darwinModules.default
  ];

  nix.settings.extra-deprecated-features = "broken-string-escape";

  system = {
    stateVersion = 6;
    primaryUser = "shakhzod";
  };
}
