{ pkgs }:
pkgs.emacsWithDoom {
  doomDir = ./doomdir;
  doomLocalDir = "~/.local/share/nmacs";
  emacs = if pkgs.stdenv.isDarwin then pkgs.emacs-macport else pkgs.emacs;
  tangleArgs = "--all config.org";
  extraPackages =
    epkgs:
    let
      extraEpkgs = with epkgs; [ ];
      extraPkgs = with pkgs; [
        nerd-fonts.jetbrains-mono
        direnv

        # Node.js ecosystem
        nodejs
        nodePackages.typescript
        nodePackages.typescript-language-server
        nodePackages.prettier
        nodePackages.bash-language-server

        # LSP servers
        vue-language-server
        tailwindcss-language-server
        vscode-json-languageserver
        yaml-language-server
        nil
        pyright
        rust-analyzer
        texlab
        haskell-language-server

        # Formatters/linters
        nixfmt-rfc-style
        shfmt
        shellcheck

        # Tools
        jq
        python312Packages.grip
        ripgrep
        git
        uv
      ];
    in
    extraEpkgs ++ extraPkgs;
}
