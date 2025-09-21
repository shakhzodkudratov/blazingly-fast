_: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      show_startup_tips = false;
      theme = "gruvbox-hard";
      simplified_ui = true;
    };
  };
}
