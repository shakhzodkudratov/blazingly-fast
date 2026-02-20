{ pkgs, modules, ... }:
{
  imports = [
    modules.custom.dock
  ];

  local.dock = {
    enable = true;
    entries = [
      { path = "${pkgs.alacritty}/Applications/Alacritty.app/"; }
    ];
  };
}
