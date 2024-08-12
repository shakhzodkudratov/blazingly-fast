{ pkgs }:
(with pkgs; [
  nil
  nixd
  nixpkgs-fmt

  firefox
  google-chrome

  thunderbird
  libsForQt5.kleopatra

  tree
  git

  steam
  heroic
  prismlauncher

  spotify
  obsidian
  onlyoffice-bin_latest
  #   kerio-control-vpnclient
  obs-studio

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

  nodejs_22
  nodePackages.pnpm
  nodePackages.yarn

  virtualenv
  htop
  inetutils

  llvmPackages.llvm
  llvmPackages.clang
  cmake
]) ++ (with pkgs.unstable; [
  zed-editor
  discord
  postman
])
