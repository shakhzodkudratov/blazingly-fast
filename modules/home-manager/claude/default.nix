{ pkgs, ... }:
let
  obra-superpowers = pkgs.fetchFromGitHub {
    owner = "obra";
    repo = "superpowers";
    rev = "v4.3.1";
    sha256 = "sha256-/3T9haaI5x7wVLAy+z8NzaH5hI1qvIa2nTKq91jNNXA=";
  };
in
{
  programs.claude-code = {
    enable = true;
    memory.source = ./CLAUDE.md;
    skills = {
      brainstorming = builtins.readFile "${obra-superpowers}/skills/brainstorming/SKILL.md";
    };
    settings.permissions = {
      allow = [
        "Task"
        "Bash(git diff:*)"
        "Bash(git remote:*)"
        "Bash(git pull:*)"
        "Bash(git checkout:*)"
        "Bash(gh:*)"
        "Bash(pnpm:*)"
        "Bash(npm:*)"
        "Bash(yarn:*)"
        "Bash(bun:*)"
        "Bash(node:*)"
        "Bash(python:*)"
        "Bash(pip:*)"
        "Bash(uv:*)"
        "Bash(poetry:*)"
        "Bash(docker:*)"
        "Bash(cargo build:*)"
        "Bash(cargo test:*)"
        "Bash(curl:*)"
        "Bash(find:*)"
        "Bash(grep:*)"
        "Bash(rg:*)"
        "Bash(ls:*)"
        "Bash(tree:*)"
        "Bash(time:*)"
        "Bash(timeout:*)"
        "Bash(cat:*)"
        "Bash(head:*)"
        "Bash(tail:*)"
        "Bash(cd:*)"
        "Bash(diff:*)"
        "Bash(sed:*)"
        "Bash(cut:*)"
        "Bash(awk:*)"
        "Bash(sort:*)"
        "Bash(uniq:*)"
        "Bash(test:*)"
        "Bash(wc:*)"
        "Bash(which:*)"
        "Bash(where:*)"
        "Bash(whoami)"
        "Bash(pwd)"
        "Bash(echo:*)"
        "Bash(printf:*)"
        "Bash(true)"
        "Bash(nix:*)"
        "Glob"
        "Grep"
        "Read"
        "Edit"
        "Write"
        "TodoWrite"
        "WebFetch"
        "WebSearch"
        "WebFetch(domain:github.com)"
        "WebFetch(domain:api.github.com)"
        "WebFetch(domain:raw.githubusercontent.com)"
        "WebFetch(domain:registry.npmjs.org)"
      ];
    };
  };
}
