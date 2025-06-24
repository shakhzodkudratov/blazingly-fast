{ pkgs }:

with pkgs;
[
  # General packages for development and system management
  alacritty
  aspell
  aspellDicts.en
  bash-completion
  bat
  btop
  coreutils
  killall
  neofetch
  openssh
  sqlite
  wget
  zip
  unzip
  lnav
  unrar
  tree
  # cargo

  # orzklv's rust rewrite packages
  btop
  bat
  eza
  procs
  ripgrep
  fd
  gping
  hyperfine

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2
  bundletool

  # Cloud-related tools and SDKs
  docker
  docker-compose

  # Media-related packages
  dejavu_fonts
  ffmpeg
  fd
  font-awesome
  hack-font
  noto-fonts
  noto-fonts-emoji
  meslo-lgs-nf
  nerd-fonts.jetbrains-mono

  # Node.js development tools
  # nodePackages.npm # globally install npm
  # nodePackages.prettier
  # nodejs
  # pnpm_10

  # Text and terminal utilities
  htop
  hunspell
  iftop
  jq
  ripgrep
  tree
  tmux
  unrar
  unzip
  zsh-powerlevel10k
  texliveFull

  # Python packages
  # python3
  # virtualenv

  # Nix related
  # nil
  # nixd
  # nixpkgs-fmt
  # nixfmt
]
