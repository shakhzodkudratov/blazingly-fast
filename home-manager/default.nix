# https://github.com/nix-community/home-manager/tree/master/modules/programs

{
  zsh = import ./zsh;
  topgrade = import ./topgrade;
  git = import ./git;
  alacritty = import ./alacritty;
  tmux = import ./tmux;
  java = import ./java;
  opam = import ./opam;
}
