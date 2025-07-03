{
  agenix,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../../modules/shared
    # ../../../modules/shared/home-manager.nix
  ];

  environment.systemPackages = [
    agenix.packages."${pkgs.system}".default
  ] ++ (import ../../../modules/shared/packages.nix { inherit pkgs; });

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "worklaptop";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tashkent";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  users.users.shakhzod = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  system.stateVersion = "25.05";
}
