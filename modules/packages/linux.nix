{ pkgs, ... }:
{
  imports = [
    ./shared.nix
  ];
  environment.systemPackages = with pkgs; [
    _1password-gui
    android-studio
    element-desktop
    floorp-bin
    google-chrome
    guvcview
    obs-studio
    obsidian
    pinentry-all
    postman
    spotify
    telegram-desktop
    vlc
    wl-clipboard
    wpsoffice
    xclip
  ];
}
