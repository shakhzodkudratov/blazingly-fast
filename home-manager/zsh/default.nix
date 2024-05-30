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
      export BLAZINGLY_FAST="/home/shakhzod/blazingly-fast"
      export PATH=$PATH:/home/shakhzod/.local/share/JetBrains/Toolbox/scripts
      alias avim="NVIM_APPNAME=astronvim nvim"
      alias zshrc="avim $BLAZINGLY_FAST/home-manager/zsh/default.nix"
      alias avimconf="avim $BLAZINGLY_FAST/home-manager/astronvim/user"
      alias nixconf="avim $BLAZINGLY_FAST"
      alias nixrebuild="git -C $BLAZINGLY_FAST add . && sudo nixos-rebuild switch --flake $BLAZINGLY_FAST#workpc"
      alias nixupdate="git -C $BLAZINGLY_FAST add . && git -C $BLAZINGLY_FAST commit -m 'automatically updated by nixupdate' && git -C $BLAZINGLY_FAST push"
      alias nix-shell="nix-shell --run zsh"
      if [[ -f shell.nix ]]; then
        nix-shell --run zsh
      fi
    '';
  };
}
