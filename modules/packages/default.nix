{
  pkgs,
  lib,
  ...
} @ args: let
  linux = import ./linux.nix args;
  darwin = import ./darwin.nix args;
  shared = import ./shared.nix args;
  systemSpecific =
    lib.linuxDarwinElse pkgs linux darwin [];
in
  systemSpecific ++ shared
