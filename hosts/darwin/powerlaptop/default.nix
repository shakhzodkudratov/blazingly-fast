{ pkgs, ... }:
{
  system = {
    stateVersion = 6;
    primaryUser = "shakhzod";
  };

  nix = {
    enable = true;
    package = pkgs.lixPackageSets.stable.lix;
  };
}
