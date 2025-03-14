{
  pkgs,
  config,
  ...
}:
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
        deadnix
        rustup # Must run `rustup default stable`
      ]
      ++ [
        config.AstroNvim.pythonPackage
        config.AstroNvim.nodePackage
        refresh
      ];
    home-manager.users.${config.AstroNvim.username}.xdg.configFile = {
      "nvim/lua" = {
        source = ../lua;
        recursive = true;
      };
      "nvim/init.lua" = {
        source = ../init.lua;
      };
    };
  };
}
