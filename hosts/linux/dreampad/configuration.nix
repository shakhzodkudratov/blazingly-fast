{
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.kernelParams = [
    # "intel_iommu=off"
    # "i915.enable_guc=3"
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices."luks-eaa96618-1505-405b-87e0-7e6ab29de6f8".device =
      "/dev/disk/by-uuid/eaa96618-1505-405b-87e0-7e6ab29de6f8";
  };

  networking = {
    hostName = "dreampad";
    networkmanager.enable = true;
    # firewall.enable = false;
  };

  time.timeZone = "Asia/Tashkent";

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "intel" ];
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    pulseaudio.enable = false;

    libinput.enable = true;
    printing.enable = true;

    # openssh = {
    #   enable = true;
    #   ports = [22];
    # };
  };

  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
    };

    intelgpu = {
      driver = "xe";
    };

    bluetooth.enable = true;
  };

  security.rtkit.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment = {
    shells = [ pkgs.zsh ];
  };

  system.stateVersion = "25.11";
}
