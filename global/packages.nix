{ pkgs }:
(with pkgs; [
  firefox
  google-chrome
  thunderbird
  tree
  git
  steam
  jetbrains-toolbox
  telegram-desktop
  webkitgtk_6_0
  nil
  nixpkgs-fmt
  _1password-gui
  termius
  spotify
  python3
  virtualenv
  bruno
  htop
  inetutils
  element-desktop
  libsForQt5.kleopatra
  llvmPackages.llvm
  llvmPackages.clang
  cmake
  onlyoffice-bin_latest
  obs-studio
  zulip
  prismlauncher
  texturepacker
  heroic
  obsidian
]) ++ (with pkgs.n2311; [
  nodejs_21
  nodePackages.pnpm
]) ++ (with pkgs.unstable; [
  zed-editor
  discord
  postman
]) ++ [
  (builtins.getFlake "github:shakhzodkudratov/kerio-control-vpnclient-nix/f8f0467ac0de89d4aacf041c17888e6a4807f730").packages.${builtins.currentSystem}.kerio-control-vpnclient
]
