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
    git
  ];
  shellHook = ''
    export EDITOR=nvim
  '';
}
