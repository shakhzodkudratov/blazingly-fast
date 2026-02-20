{ inputs, ... }:
{
  imports = [
    inputs.determinate.darwinModules.default
  ];

  system = {
    stateVersion = 6;
    primaryUser = "shakhzod";
  };

  nix.enable = false;

  determinateNix.customSettings = {
    eval-cores = 0;
    extra-experimental-features = [
      "build-time-fetch-tree"
      "parallel-eval"
    ];
  };
}
