{
  pkgs,
  modules,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    modules.configurations
    modules.nix
    modules.astronvim-nix-nixos
    modules.packages
    modules.users.shakhzod
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

    initrd.luks.devices."luks-eaa96618-1505-405b-87e0-7e6ab29de6f8".device = "/dev/disk/by-uuid/eaa96618-1505-405b-87e0-7e6ab29de6f8";
  };

  networking = {
    hostName = "dreampad";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Tashkent";

  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["intel"];
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

    openssh = {
      enable = true;
      ports = [22];
    };

    kmonad = {
      enable = true;
      keyboards.builtin = {
        device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
        config = builtins.readFile ./keyboard.kbd;

        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = true;
        };
      };
    };
  };

  hardware.bluetooth.enable = true;

  security.rtkit.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment = {
    shells = [pkgs.zsh];
  };

  system.stateVersion = "25.05";
}
