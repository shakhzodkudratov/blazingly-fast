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
      export PATH=$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts:$HOME/.cargo/bin
      alias avim="NVIM_APPNAME=astronvim nvim"
      alias zshrc="avim $BLAZINGLY_FAST/home-manager/zsh/default.nix"
      alias avimconf="avim $BLAZINGLY_FAST/home-manager/astronvim/user"
      alias nixconf="avim $BLAZINGLY_FAST"
      alias nixrebuild="git -C $BLAZINGLY_FAST add . && sudo nixos-rebuild switch --flake $BLAZINGLY_FAST --impure"
      alias nixpull="git -C $BLAZINGLY_FAST pull"
      alias nixpush="git -C $BLAZINGLY_FAST add . && git -C $BLAZINGLY_FAST commit -m 'automatically updated by nixupdate' && git -C $BLAZINGLY_FAST push"
      alias nixupgrade="sudo nix flake update $BLAZINGLY_FAST && nixrebuild"
      alias nix-shell="INNIXSHELL=true nix-shell --run zsh"
      if [ -z $INNIXSHELL ] && [ -f shell.nix ]; then
        INNIXSHELL=true nix-shell --run zsh
      fi
      export NIXPKGS_ALLOW_UNFREE=1
      eval "$(zoxide init zsh)"
    '';
  };
}
