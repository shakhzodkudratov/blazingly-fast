{
  inputs,
  system,
  pkgs,
}:
let
  inherit
    (pkgs.callPackage ./secrets/scripts.nix {
      inherit pkgs;
      inherit (inputs) opsops;
    })
    opsops-full
    prepare-sops
    ;
in
pkgs.mkShellNoCC {
  packages = with pkgs; [
    inputs.self.formatter.${system}
    nixfmt-tree

    nixd
    deadnix
    statix

    git

    opsops-full
    prepare-sops
  ];

  shellHook = ''
    export EDITOR="nvim"
    export FLAKE_ROOT="$(git rev-parse --show-toplevel)"
  '';
}
