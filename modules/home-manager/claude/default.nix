{ pkgs, isDarwin, ... }:
{
  programs.claude-code = {
    enable = true;

    package =
      if isDarwin then
        pkgs.writeShellScriptBin "claude-wrapper" ''
          echo "Hello from claude"
        ''
      else
        pkgs.claude-code;

    memory.source = ./CLAUDE.md;
  };
}
