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

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" ];
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelModules = [ "v4l2loopback" ];
  };

  environment.systemPackages = globalPackages ++ (with pkgs; [
    steam
  ]);

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

    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;

    blueman.enable = true;
    teamviewer.enable = true;
  };

  system.stateVersion = "24.11";
}
