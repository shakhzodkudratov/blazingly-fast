{
  pkgs,
  lib,
  ...
} @ args: let
  linux = import ./linux.nix args;
  darwin = import ./darwin.nix args;
  shared = import ./shared.nix args;
  homebrew = import ./homebrew.nix args;
in
  lib.mkMerge [
    (lib.mkIf pkgs.stdenv.isLinux {
      environment.systemPackages = linux ++ shared;
    })
    (lib.mkIf pkgs.stdenv.isDarwin {
        environment.systemPackages = darwin ++ shared;
      }
      // homebrew)
  ]
