_: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    installVimSyntax = true;
    settings = {
      theme = "gruvbox";
      font-feature = "+calt, +liga";
    };
    systemd.enable = true;
    themes.gruvbox = {
      background = "#282828";
      cursor-color = "#d4be98";
      foreground = "#d4be98";
      palette = [
        "0=#1b1b1b"
        "1=#ea6962"
        "2=#a9b665"
        "3=#d8a657"
        "4=#7daea3"
        "5=#d3869b"
        "6=#89b482"
        "7=#d4be98"
        "8=#32302f"
        "9=#ea6962"
        "10=#a9b665"
        "11=#d8a657"
        "12=#7daea3"
        "13=#d3869b"
        "14=#89b482"
        "15=#d4be98"
      ];
      selection-background = "#3c3836";
      selection-foreground = "#d4be98";
    };
  };
}
