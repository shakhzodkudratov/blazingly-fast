{ config, lib, pkgs, inputs, outputs, ... }:
let
  globalPackages = import ../../common/packages.nix { inherit pkgs; };
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../../common/configuration.nix
    ../../users/shakhzod/configuration.nix
  ];

  environment.systemPackages = globalPackages;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  networking.hostName = "dreampad";

  services = {
    xserver = {
      enable = true;
    };

    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;

    blueman.enable = true;
  };

  system.stateVersion = "24.11";
}
