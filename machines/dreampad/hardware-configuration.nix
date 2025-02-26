# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/1c5dd3b4-10b7-4857-8275-6cd41f5cf40f";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-c7f7ef5e-c6ef-428a-8aca-a018910bade4".device = "/dev/disk/by-uuid/c7f7ef5e-c6ef-428a-8aca-a018910bade4";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/35F3-7B5F";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  # this causing long sysinit-reactivation restart
  # swapDevices =
  #   [ { device = "/dev/disk/by-uuid/cbf66084-0ed7-494d-87d5-3d2b2e5b6f1c"; }
  #   ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp4s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
