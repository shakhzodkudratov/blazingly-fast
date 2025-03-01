{ pkgs, ... }:
{
  enableMan = false;
  # Import all your configuration modules here
  imports = [
    ./autocmd.nix
    ./settings.nix
    ./lazy.nix
    ./keymaps
    ./plugins
  ];

  extraPackages = with pkgs; [
    ripgrep
    lazygit
    fzf
    fd
  ];
}
