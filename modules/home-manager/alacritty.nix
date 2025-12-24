{
  lib,
  pkgs,
  ...
}:
{
  programs.alacritty = {
    enable = true;
    settings = {
      cursor = {
        style = "Block";
      };

      window = {
        option_as_alt = "Both";
        opacity = 1.0;
        padding = {
          x = 2;
          y = 2;
        };
      };

      keyboard = {
        bindings = [
          {
            key = "N";
            mods = "Command|Shift";
            action = "CreateNewTab";
          }
          {
            key = "I";
            mods = "Command|Shift";
            action = "SelectNextTab";
          }
          {
            key = "H";
            mods = "Command|Shift";
            action = "SelectPreviousTab";
          }
        ];
      };

      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = lib.mkMerge [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux 10)
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin 14)
        ];
      };

      colors = {
        primary = {
          background = "0x282828";
          foreground = "0xd4be98";
        };

        normal = {
          black = "0x3c3836";
          blue = "0x7daea3";
          cyan = "0x89b482";
          green = "0xa9b665";
          magenta = "0xd3869b";
          red = "0xea6962";
          white = "0xd4be98";
          yellow = "0xd8a657";
        };

        bright = {
          black = "0x3c3836";
          blue = "0x7daea3";
          cyan = "0x89b482";
          green = "0xa9b665";
          magenta = "0xd3869b";
          red = "0xea6962";
          white = "0xd4be98";
          yellow = "0xd8a657";
        };
      };
    };
  };
}
