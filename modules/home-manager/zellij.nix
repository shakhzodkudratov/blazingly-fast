_: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      show_startup_tips = false;
      show_release_notes = false;
      theme = "gruvbox-hard";
      simplified_ui = false;
      pane_frames = false;
      styled_underlines = false;
    };
  };
}
