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
  floorp

  thunderbird
  libsForQt5.kleopatra

  tree
  git

  btop
  bat
  eza
  procs
  ripgrep
  fd
  gping
  hyperfine
  unzip

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

  python3
  jetbrains-toolbox
  texturepacker
  android-studio

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
  teamviewer

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
