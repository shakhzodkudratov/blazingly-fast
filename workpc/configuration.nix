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
    kernelPackages = pkgs.linuxPackages_xanmod;

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

  fonts =
    {
      fontDir.enable = true;
      enableDefaultPackages = true;
      packages = with pkgs; [
        ubuntu_font_family
        noto-fonts
        noto-fonts-emoji
        noto-fonts-cjk
        jetbrains-mono
        (nerdfonts.override {
          fonts = [ "JetBrainsMono" ];
        })
      ];

      fontconfig = {
        defaultFonts = {
          # serif = [ "Ubuntu" ];
          # sansSerif = [ "Ubuntu" ];
          monospace = [ "JetBrainsMono" ];
        };
      };
    };

  services = {
    xserver = {
      enable = true;
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
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };


  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

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

  system.stateVersion = "24.05";
}
