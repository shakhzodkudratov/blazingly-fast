# imported in @/flake.nix
# https://github.com/nix-community/home-manager/tree/master/modules/programs
# https://home-manager-options.extranix.com/

{
  dotfiles = import ../../dotfiles;
  zsh = import ./zsh;
  topgrade = import ./topgrade;
  git = import ./git;
  alacritty = import ./alacritty;
  tmux = import ./tmux;
  nvim = import ./nvim;
  zellij = import ./zellij;
}
