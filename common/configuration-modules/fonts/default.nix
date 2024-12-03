{ pkgs, ... }: {
  fonts =
    {
      fontDir.enable = true;
      enableDefaultPackages = true;
      packages = with pkgs; [
        ubuntu_font_family
        noto-fonts
        noto-fonts-emoji
        noto-fonts-cjk-sans
        jetbrains-mono
        (nerdfonts.override {
          fonts = [ "JetBrainsMono" ];
        })
      ];

      fontconfig = {
        defaultFonts = {
          # serif = [ "Ubuntu" ];
          # sansSerif = [ "Ubuntu" ];
          monospace = [ "JetBrainsMono" ];
        };
      };
    };
}
