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
    (lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      environment.systemPackages = linux ++ shared;
    })
    (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      environment.systemPackages = darwin ++ shared;
    })
    (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin homebrew)
  ]
