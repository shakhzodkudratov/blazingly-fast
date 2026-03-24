{
  lib,
  pkgs,
  isDarwin,
  isLinux,
  ...
}:
let
  blazingly-fast = "~/blazingly-fast";
  inherit (pkgs) writeShellScriptBin;

  rebuildCmd = if isDarwin then "sudo darwin-rebuild switch" else "sudo nixos-rebuild switch";

  nixrebuild = writeShellScriptBin "nixrebuild" ''
    set -euo pipefail
    git -C ${blazingly-fast} add .
    ${rebuildCmd} \
      --flake ${blazingly-fast} \
      --impure \
      "$@"
  '';

  nixcleanup = writeShellScriptBin "nixcleanup" (
    ''
      set -euo pipefail
      sudo nix-collect-garbage -d
      nix-collect-garbage -d
      nix store optimise
    ''
    + lib.optionalString isLinux ''
      sudo /run/current-system/bin/switch-to-configuration switch
    ''
  );

  nixupgrade = writeShellScriptBin "nixupgrade" ''
    set -euo pipefail
    nix flake update --flake ${blazingly-fast} "$@"
    ${nixrebuild}/bin/nixrebuild
  '';

  nixpull = writeShellScriptBin "nixpull" ''
    set -euo pipefail
    git -C ${blazingly-fast} pull
  '';

  nixpush = writeShellScriptBin "nixpush" ''
    set -euo pipefail
    read -p "Commit message (enter for default): " msg
    git -C ${blazingly-fast} add .
    git -C ${blazingly-fast} commit -m "''${msg:-automatically updated by nixpush}"
    git -C ${blazingly-fast} push
  '';
in
{
  home.packages = [
    nixrebuild
    nixcleanup
    nixupgrade
    nixpull
    nixpush
  ];
}
