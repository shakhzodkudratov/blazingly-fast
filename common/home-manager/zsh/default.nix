{ pkgs, ... }: {
  imports = [
    ./aliases.nix
    ./zoxide.nix
    ./starship.nix
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = { };

    initExtra = ''
      export BLAZINGLY_FAST="/home/shakhzod/blazingly-fast"
      export PATH=$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts:$HOME/.cargo/bin
      export NIXPKGS_ALLOW_UNFREE=1
      eval "$(zoxide init zsh)"
    '';
  };
}
