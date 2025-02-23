{ pkgs, inputs, ... }:
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

  environment.systemPackages = globalPackages ++ [
    pkgs.clinfo
  ];

  boot = {
    kernelParams = [ "radeon.cik_support=0" "amdgpu.cik_support=1" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.kernelModules = [ "amdgpu" ];
  };

  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

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
      videoDrivers = [ "amdgpu" ];
    };

    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;

    blueman.enable = true;
  };

  system.stateVersion = "24.11";
}
