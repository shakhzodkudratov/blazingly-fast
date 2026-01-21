{ inputs, ... }:
{
  imports = [
    inputs.determinate.darwinModules.default
  ];

  nix.enable = false;

  determinate-nix.customSettings = {
    eval-cores = 0;
    extra-experimental-features = [
      "build-time-fetch-tree"
      "parallel-eval"
    ];
  };
}
