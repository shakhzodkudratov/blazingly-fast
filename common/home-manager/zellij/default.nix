{ ... }:
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      theme = "gruvbox-hard";
      simplified_ui = true;
    };
  };
}
