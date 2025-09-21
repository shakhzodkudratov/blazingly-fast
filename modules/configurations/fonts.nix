{pkgs, ...}: {
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      liberation_ttf
      times-newer-roman
      ubuntu_font_family
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      jetbrains-mono
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Times Newer Roman"];
        sansSerif = ["Noto Sans"];
        monospace = ["JetBrainsMono"];
      };
    };
  };
}
