{ ... }: {
  programs.zellij = {
    enable = true;
    # enableZshIntegration = true; <- be careful, it autoopens zellij
  };
}
