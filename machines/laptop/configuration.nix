{ pkgs, inputs, config, ... }:
let
  globalPackages = import ../../common/packages.nix { inherit pkgs; };
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../../common/configuration.nix
    ../../common/configuration-modules/kmonad/default.nix
    ../../users/shakhzod/configuration.nix
  ];

  environment.systemPackages = globalPackages ++ [];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
    };
 

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  networking.hostName = "laptop";

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
    };

    blueman.enable = true;
  };

  system.stateVersion = "24.11";
}
