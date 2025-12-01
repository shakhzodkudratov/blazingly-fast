{
  pkgs,
  config,
  ...
}: {
  programs.claude-code = {
    enable = true;
    memory.source = ./CLAUDE.md;
  };
}
