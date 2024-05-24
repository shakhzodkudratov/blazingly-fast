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
      alias nvimconf="nvim /home/shakhzod/blazingly-fast/home-manager/astronvim/user"
      alias nixconf="nvim /home/shakhzod/blazingly-fast"
      alias nixrebuild="git -C /home/shakhzod/blazingly-fast add . && sudo nixos-rebuild switch --flake /home/shakhzod/blazingly-fast/#workpc && git -C /home/shakhzod/blazingly-fast commit -m 'automatically created by nixrebuild' && git -C /home/shakhzod/blazingly-fast push"
    '';
  };
}
