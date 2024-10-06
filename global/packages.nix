{ pkgs }:
(with pkgs; [
  nil
  nixd
  nixpkgs-fmt

  firefox
  google-chrome
  ladybird

  thunderbird
  libsForQt5.kleopatra

  tree
  git
  zoxide

  steam
  heroic
  prismlauncher

  spotify
  obsidian
  anytype
  onlyoffice-bin_latest

  obs-studio
  vlc
  lorien
  guvcview
  v4l-utils
  gphoto2
  ffmpeg

  python3
  jetbrains-toolbox
  texturepacker

  telegram-desktop
  element-desktop
  zulip

  webkitgtk_6_0

  _1password-gui
  termius
  bruno

  virtualenv
  htop
  inetutils

  llvmPackages.llvm
  llvmPackages.clang
  cmake
]) ++ (with pkgs.unstable; [
  zed-editor
  vscode
  discord
  postman
  
  nodejs_22
  pnpm
  yarn
])
