{ pkgs, inputs, outputs, ... }:
let
  globalPackages = import ./packages.nix { inherit pkgs; };
in
{
  # this imports all configuration modules modules from @/common/configuration-modules
  imports = (builtins.attrValues outputs.configurationModules);

  # PACKAGES
  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];
    systemPackages = globalPackages;
  };

  # EXTRA
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  networking.networkmanager.enable = true;
  # programs.mtr.enable = true;

  virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;

  # https://github.com/Mic92/envfs
  services.envfs.enable = true;

  time.timeZone = "Asia/Tashkent";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    # useXkbConfig = true; # use xkb.options in tty.
  };
}
