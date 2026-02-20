{ pkgs, ... }:
{
  home.packages = [ pkgs.gh ];
  programs.gh = {
    enable = false;
  };
}
