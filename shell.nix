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
    alejandra
    git
  ];
  shellHook = ''
    export EDITOR=nvim
  '';
}
