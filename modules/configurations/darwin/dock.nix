{  modules, ... }:
{
  imports = [
    modules.custom.dock
  ];

  local.dock = {
    enable = true;
    entries = [];
  };
}
