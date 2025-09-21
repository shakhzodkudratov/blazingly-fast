{flags, ...}:
if flags.niri.enable
then {
  programs.niri.enable = true;
}
else {}
