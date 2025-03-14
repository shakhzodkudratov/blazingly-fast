{ pkgs, config, ... }:
{
  config.fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ config.AstroNvim.nerdfont ]; })
      font-awesome
    ];
  };
}
