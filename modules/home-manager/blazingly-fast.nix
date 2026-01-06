{ pkgs, ... }:
let
  blazingly-fast = "~/blazingly-fast";
  shared = {
    nixupgrade = "nix flake update --flake ${blazingly-fast} $1 && nixrebuild";
    nixpull = "cd ${blazingly-fast} && git pull && cd -";
    nixpush = "cd ${blazingly-fast} && git add . && git commit -m \"automatically updated by nixpush\" && git push && cd -";
  };
  linux = {
    nixrebuild = "git -C ${blazingly-fast} add . && sudo nixos-rebuild switch --flake ${blazingly-fast} --impure $1";
    nixcleanup = "nix-env --delete-generations +2 && nix store gc && nix-channel --update && nix-env -u --always && nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration switch";
  };
  darwin = {
    nixrebuild = "git -C ${blazingly-fast} add . && sudo darwin-rebuild switch --flake ${blazingly-fast} --impure $1";
    nixcleanup = "nix store gc";
  };
  commands =
    shared
    // (
      if pkgs.stdenv.isLinux then
        linux
      else if pkgs.stdenv.isDarwin then
        darwin
      else
        { }
    );
  commands' = pkgs.lib.mapAttrsToList (key: content: pkgs.writeShellScriptBin key content) commands;
in
{
  home.packages = commands';
}
