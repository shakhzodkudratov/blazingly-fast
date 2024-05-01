{ config, lib, pkgs, outputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [
      outputs.overlays.unstable-packages
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
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      videoDrivers = [ "nvidia" ];
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  users.users.shakhzod = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = (with pkgs; [
      firefox
      tree
      alacritty
      tmux
      git
      steam
      jetbrains.webstorm
      jetbrains.pycharm-professional
      jetbrains.goland
      jetbrains.rust-rover
      jetbrains.clion
      jetbrains.idea-ultimate
      jetbrains.datagrip
      jetbrains.phpstorm
    ])
    ++ (with pkgs.unstable; [
      vscode
      zed-editor
    ]);
  };

  environment.systemPackages = with pkgs; [
    vim 
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # system.copySystemConfiguration = true;

  system.stateVersion = "23.11";

}

