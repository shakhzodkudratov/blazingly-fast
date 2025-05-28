{ pkgs, ... }:
{
  config.fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      font-awesome
    ];
  };
}
