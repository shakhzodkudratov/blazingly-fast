{ pkgs, config, ... }:
let
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
  replace-contents = import ../../../utils/replace-contents.nix;
in
{
  imports = [ ./options.nix ];
  config = {
    environment.systemPackages =
      with pkgs;
      [
        # Essential
        neovim-unwrapped
        ripgrep
        lazygit
        gdu
        bottom
        # LSP dependencies
        stylua
        selene
        ruff
        nixd
        nixfmt-rfc-style
        statix
        deadnix
        # rustup # Must run `rustup default stable`
        cornelis

        # haskell-language-server

        # python314Full
        # nodejs_24
      ]
      ++ [ refresh ];
    home-manager.users.${config.AstroNvim.username}.xdg.configFile = {
      "nvim/init.lua" = {
        source = ../init.lua;
      };
      "nvim/lua" = {
        source = ../lua;
        recursive = true;
      };
      "nvim/extra-lua/cornelis.lua" = {
        text = replace-contents (builtins.readFile ../extra-lua/cornelis.lua) {
          "cornelis" = pkgs.vimPlugins.cornelis;
        };
      };
    };
  };
}
