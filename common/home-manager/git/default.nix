{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "Shakhzod Kudratov";
    userEmail = "shakhzodkudratov@gmail.com";

    signing = {
      signByDefault = true;
      key = "5A1E1590CA201638ECCF834FD98C2DC59CFA95D4";
    };

    ignores = [
      ".idea"
      "node_modules"
    ];

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      pull.rebase = "true";
      push.autoSetupRemote = "true";
    };
  };
}
