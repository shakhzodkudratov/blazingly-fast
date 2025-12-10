{
  pkgs,
  config,
  lib,
  ...
}: let
  refresh = pkgs.writeScriptBin "nvim-refresh" ''
    rm -rf ~/.config/nvim/lazy-lock.json
    rm -rf ~/.config/lvim

    rm -rf ~/.cache/lvim
    rm -rf ~/.cache/nvim

    rm -rf ~/.local/share/lvim
    rm -rf ~/.local/share/nvim

    rm -rf ~/.local/state/lvim
    rm -rf ~/.local/state/nvim
  '';
in {
  imports = [./options.nix];
  config = {
    environment.systemPackages = with pkgs;
      [
        # Essential
        neovim-unwrapped
        # ripgrep
        # lazygit
        # gdu
        # bottom
        # # LSP dependencies
        # stylua
        # selene
        # ruff
        nixd
        # # nixfmt-rfc-style
        # alejandra
        statix
        deadnix
        # # rustup # Must run `rustup default stable`
        # cornelis
        # taplo
        # bash
        # nodejs
        # go
        #
        # haskell-language-server

        # python3
        # cmake
        # llvmPackages.llvm
        # llvmPackages.clang
        # cargo
        # rustc

        # elan
      ]
      ++ [refresh];
    home-manager.users.${config.AstroNvim.username}.xdg.configFile = {
      "nvim/init.lua" = {
        source = ../init.lua;
      };
      "nvim/lua" = {
        source = ../lua;
        recursive = true;
      };
      "nvim/extra-lua/cornelis.lua" = {
        text = lib.replaceContents (builtins.readFile ../extra-lua/cornelis.lua) {
          "cornelis" = pkgs.vimPlugins.cornelis;
        };
      };
    };
  };
}
