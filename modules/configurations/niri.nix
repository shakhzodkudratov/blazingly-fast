{
  flags,
  pkgs,
  ...
}:
if flags.niri.enable
then {
  # imports = [inputs.niri.nixosModules.niri];

  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;
  };
}
else {}
