{ pkgs, ... }@args:
let
  shared = import ./shared.nix args;
in
{
  environment.systemPackages =
    shared
    + (with pkgs; [
      _1password-gui
      spotify
      telegram-desktop
      element-desktop
      obsidian
      floorp-bin
      pinentry-all
      android-studio
      google-chrome
      element-desktop
      xclip
      wl-clipboard
      wpsoffice
      obs-studio
      guvcview
      postman
      vlc
    ]);
}
