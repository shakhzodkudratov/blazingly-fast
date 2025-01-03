{ outputs, ... }: {
  # this imports all home-manager modules from @/common/home-manager
  imports = (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    overlays = [
      outputs.overlays.nix-channels
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    stateVersion = "24.11";
    username = "shakhzod";
    homeDirectory = "/home/shakhzod";
    enableNixpkgsReleaseCheck = false;
  };

  programs = {
    home-manager.enable = true;
    direnv.enable = true;
  };
}
