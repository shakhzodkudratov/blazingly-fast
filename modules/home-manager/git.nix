_: {
  programs.git = {
    enable = true;
    lfs.enable = true;

    ignores = [
      ".idea"
      "node_modules"
      ".DS_Store"
      "*.swp"
    ];

    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      commit.gpgsign = true;
      pull.rebase = true;
      rebase.autoStash = true;
      push.autoSetupRemote = true;
    };
  };
}
