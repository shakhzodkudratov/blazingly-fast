{ m, ... }:
{
  imports = [
    m.modules.dock
  ];

  local.dock = {
    enable = true;
    entries = [ ];
  };
}
