{flags, ...}:
if flags.plasma.enable
then {
  services = {
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };
}
else {}
