{ config, lib, pkgs, inputs, outputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./users.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [
      outputs.overlays.nix-channels
    ];
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

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

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  networking.hostName = "workpc";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tashkent";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  services = {
    xserver = {
      enable = true;
      # desktopManager.plasma5.enable = true;
      videoDrivers = [ "nvidia" ];
    };

    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;

    # https://github.com/Mic92/envfs
    envfs.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    enableNvidia = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };


  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      vim
      wget
      curl
      envfs
    ];
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  system.stateVersion = "23.11";
}
