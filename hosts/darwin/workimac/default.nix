{ inputs, ... }:
{
  imports = [
    inputs.lix-module.darwinModules.default
  ];

  nix.settings = {
    extra-experimental-features = [
      "flakes"
      "nix-command"
    ];
    extra-deprecated-features = "broken-string-escape";
  };

  system = {
    stateVersion = 6;
    primaryUser = "shakhzod";
  };
}
