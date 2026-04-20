{ pkgs, ... }:
let
  nmacs = pkgs.callPackage ../nmacs/nmacs.nix { };
in
{
  home.packages = [
    nmacs
    # (pkgs.writeShellScriptBin "ec" ''
    #   exec ${nmacs}/bin/emacsclient -c -a "" "$@"
    # '')
    # (pkgs.writeShellScriptBin "et" ''
    #   exec ${nmacs}/bin/emacsclient -t -a "" "$@"
    # '')
  ];
}
