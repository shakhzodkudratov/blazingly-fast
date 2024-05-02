{ inputs, lib, pkgs, config, outputs, packages, ... }: {
  imports = (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    overlays = [
      outputs.overlays.unstable-packages
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    stateVersion = "23.11";
    username = "shakhzod";
    homeDirectory = "/home/shakhzod";
    enableNixpkgsReleaseCheck = false;
  };

  programs.home-manager.enable = true;
}
