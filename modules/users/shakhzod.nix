{
  lib,
  pkgs,
  modules,
  ...
} @ args: let
  user = "shakhzod";
  name = "Shakhzod Kudratov";
  email = "shakhzodkudratov@gmail.com";
in {
  users.users.${user} = {
    isNormalUser = true;
    description = "Shakhzod";
    extraGroups = ["networkmanager" "wheel" "docker"];
    shell = lib.getExe pkgs.zsh;
  };

  AstroNvim = {
    enable = true;
    username = user;
  };

  home-manager.users.${user} = lib.recursiveUpdate (modules.home-manager args) {
    programs.git = {
      settings.user = {
        inherit name email;
      };

      signing = {
        signByDefault = true;
        key = "5A1E1590CA201638ECCF834FD98C2DC59CFA95D4";
      };
    };
  };
}
