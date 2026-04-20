{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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
