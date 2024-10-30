{ config, lib, pkgs, inputs, outputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../../common/configuration.nix
    ../../users/shakhzod/configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  networking.hostName = "workpc";

  services = {
    xserver = {
      enable = true;
    };

    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;

    blueman.enable = true;
  };

  system.stateVersion = "24.05";
}
