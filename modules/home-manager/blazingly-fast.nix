{
  lib,
  pkgs,
  isDarwin,
  isLinux,
  ...
}:
let
  blazingly-fast = "~/blazingly-fast";
  attrsToCommand =
    attrs: pkgs.lib.mapAttrsToList (key: content: pkgs.writeShellScriptBin key content) attrs;
in
{
  home.packages = attrsToCommand (
    (lib.optionalAttrs isDarwin {
      nixrebuild = "git -C ${blazingly-fast} add . && sudo darwin-rebuild switch --flake ${blazingly-fast} --impure $1";
      nixcleanup = "nix store gc";
    })
    // (lib.optionalAttrs isLinux {
      nixrebuild = "git -C ${blazingly-fast} add . && sudo nixos-rebuild switch --flake ${blazingly-fast} --impure $1";
      nixcleanup = "nix-env --delete-generations +2 && nix store gc && nix-channel --update && nix-env -u --always && nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration switch";
    })
    // {
      nixupgrade = "nix flake update --flake ${blazingly-fast} $1 && nixrebuild";
      nixpull = "cd ${blazingly-fast} && git pull && cd -";
      nixpush = "cd ${blazingly-fast} && git add . && git commit -m \"automatically updated by nixpush\" && git push && cd -";
    }
  );
}
