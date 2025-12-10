{
  lib,
  pkgs,
  ...
} @ args: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "sha256-Z6EYQdasvpl1P78poj9efnnLj7QQg13Me8x1Ryyw+dM=";
        };
      }
      {
        name = "zsh-fzf-history-search";
        file = "zsh-fzf-history-search.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "joshskidmore";
          repo = "zsh-fzf-history-search";
          rev = "master";
          sha256 = "sha256-6UWmfFQ9JVyg653bPQCB5M4jJAJO+V85rU7zP4cs1VI=";
        };
      }
    ];
    shellAliases = import ./aliases.nix args;

    initContent = lib.mkAfter ''
      export BLAZINGLY_FAST="$HOME/blazingly-fast"
      export NIX_SHELL_WORKSPACE="$HOME/dev/nix-shell-workspace"


      if [ -f "$HOME/.zshrc_custom" ]; then
        source "$HOME/.zshrc_custom"
      fi

      ${
        if pkgs.stdenv.hostPlatform.isDarwin
        then ''
          eval "$(/opt/homebrew/bin/brew shellenv)"
        ''
        else ""
      }
    '';
  };
}
