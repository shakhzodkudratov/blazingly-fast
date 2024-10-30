{ ... }: {
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    prefix = "$";
    extraConfig = (builtins.readFile ./tmux.conf);
  };
}
