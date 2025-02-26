{
  docker = import ./docker;
  gnupg = import ./gnupg;
  nix-ld = import ./nix-ld;
  nixpkgs = import ./nixpkgs;
  sound = import ./sound;
  fonts = import ./fonts;
  keyboard-layouts = import ./keyboard-layouts;
  cachix = import ./cachix;
  xmonad = import ./xmonad;
}
