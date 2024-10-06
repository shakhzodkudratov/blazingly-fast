# https://github.com/nix-community/home-manager/tree/master/modules/programs
# https://home-manager-options.extranix.com/

{
  zsh = import ./zsh;
  topgrade = import ./topgrade;
  git = import ./git;
  alacritty = import ./alacritty;
  tmux = import ./tmux;
  astronvim = import ./astronvim;
  zellij = import ./zellij;
}
