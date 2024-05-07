{ pkgs, ... }: {
  programs.java = { enable = true; package = pkgs.jetbrains.jdk; };
}
