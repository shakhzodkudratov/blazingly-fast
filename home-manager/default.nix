# https://github.com/nix-community/home-manager/tree/master/modules/programs
# https://home-manager-options.extranix.com/

{
  zsh = import ./zsh;
  topgrade = import ./topgrade;
  git = import ./git;
  alacritty = import ./alacritty;
  tmux = import ./tmux;
  java = import ./java;
  opam = import ./opam;
  direnv = import ./direnv;
  astronvim = import ./astronvim;
}
