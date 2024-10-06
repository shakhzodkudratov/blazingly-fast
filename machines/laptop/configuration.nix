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
      outputs.overlays.extra-packages
    ];
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  boot = {
    # kernelPackages = pkgs.linuxPackages_6_10;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    kernelModules = [ "v4l2loopback" ];
    extraModprobeConfig = ''
      options v4l2loopback devices=3 video_nr=7,8,9 card_label="OBSCam,ScreenCam,DiscordCam" exclusive_caps=1,1,1
    '';
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
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
      videoDrivers = [ "nvidia" ];
    };

    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;
    # https://github.com/Mic92/envfs
    envfs.enable = true;
    blueman.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "shakhzod" ];

  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  sound.enable = true;

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
