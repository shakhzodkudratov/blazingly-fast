{ pkgs, ... }:
{
  xdg.configFile.astronvim = {
    source = ./.;
    recursive = true;
  };

  programs.neovim = {
    enable = true;

    extraWrapperArgs = [
      "--suffix"
      "NVIM_APPNAME"
      ":"
      "astronvim"
    ];

    extraPackages = with pkgs; [
      nodejs
      selene
      nixd
      deadnix
      statix
      gdu
      lazygit
      python3

      lua-language-server
      luarocks
      stylua

      tree-sitter
    ];
  };
}
