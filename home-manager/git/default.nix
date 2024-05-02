{ ... }: {
  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = "Shakhzod Kudratov";
    userEmail = "shakhzodkudratov@gmail.com";

    signing = {
      signByDefault = true;
      key = "D3884ED5F00C62CEE1B35DEAA29C0F920936E9DE";
    };

    ignores = [
      ".idea"
      "node_modules"
    ];
  };
}
