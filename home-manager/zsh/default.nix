{ ... }: {
  imports = [
    ./starship.nix
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    shellAliases = { };

    initExtra = ''
      export PATH=$PATH:/home/shakhzod/.local/share/JetBrains/Toolbox/scripts
    '';
  };
}
