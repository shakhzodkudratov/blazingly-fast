# imported in @/common/home-manager/default.nix

{ config, ... }: {
  xdg.enable = true;
  xdg.configFile = {
    "astronvim".source = config.lib.file.mkOutOfStoreSymlink "/home/shakhzod/blazingly-fast/dotfiles/astronvim";
  };
}
