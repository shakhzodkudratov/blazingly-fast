{ pkgs, ... }:
{
  icons = import ./icons.nix;

  # To add packages from from inputs
  mkPkgs = name: src: pkgs.vimUtils.buildVimPlugin { inherit name src; };
}
