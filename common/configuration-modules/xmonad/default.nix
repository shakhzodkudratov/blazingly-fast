{ pkgs, inputs, ... }:
{
  services.picom.enable = true;
  services.xserver = {
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;

      ghcArgs = [
        "-hidir /tmp"
        "-odir /tmp"
        "-i${inputs.xmonad-contexts}"
      ];

      extraPackages = haskellPackages: [
        haskellPackages.dbus
        haskellPackages.List
        haskellPackages.monad-logger
      ];

      config = builtins.readFile ../../../dotfiles/xmonad/xmonad.hs;
    };

    displayManager.sessionCommands = ''
      xset -dpms  # Disable Energy Star, as we are going to suspend anyway and it may hide "success" on that
      xset s blank # `noblank` may be useful for debugging
      xset s 300 # seconds
      ${pkgs.lightlocker}/bin/light-locker --idle-hint &
    '';
  };

  systemd.targets.hybrid-sleep.enable = true;
  services.logind.extraConfig = ''
    IdleAction=hybrid-sleep
    IdleActionSec=20s
  '';
}
