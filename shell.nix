{
  pkgs,
  mkShell,
  ...
}:
mkShell {
  nativeBuildInputs = with pkgs; [
    nixd
    deadnix
    statix
    nixfmt-rfc-style
    nixfmt-tree
    git
  ];
  shellHook = ''
    export EDITOR=nvim
  '';
}
