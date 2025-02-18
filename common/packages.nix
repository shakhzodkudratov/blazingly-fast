# imported in @/common/configuration.nix

{ pkgs }:
(with pkgs; [
  nil
  nixd
  nixpkgs-fmt
  cargo

  firefox
  google-chrome
  # ladybird

  thunderbird
  libsForQt5.kleopatra

  tree
  git
  unzip
  unrar

  btop
  bat
  eza
  procs
  ripgrep
  fd
  gping
  hyperfine
  unzip
  lnav
  keymapp

  spotify
  obsidian
  anytype
  onlyoffice-bin_latest

  (wrapOBS {
    plugins = with obs-studio-plugins; [
      droidcam-obs
    ];
  })
  droidcam
  vlc
  lorien
  guvcview
  v4l-utils
  gphoto2
  ffmpeg
  filelight

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
  transmission_4
  transmission_4-qt

  virtualenv
  htop
  inetutils
  teamviewer

  llvmPackages.llvm
  llvmPackages.clang
  cmake
]) ++ (with pkgs.unstable; [
  zed-editor
  vscode
  discord
  postman

  nodejs_23
  pnpm_10
  yarn

  floorp
]) ++ [
    (builtins.getFlake "github:shakhzodme/pcmd-nix/main").packages.${builtins.currentSystem}.default
    (builtins.getFlake "github:shakhzodkudratov/kerio-control-vpnclient-nix/main").packages.${builtins.currentSystem}.default
]
