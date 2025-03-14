{ ... }:
{
  services = {
    xserver.xkb = {
      options = "compose:ralt";
      layout = "us";
    };

    kmonad = {
      enable = true;
      keyboards = {
        laptop-gallum = {
          name = "laptop-gallum";
          device = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";

          defcfg = {
            enable = true;
            fallthrough = true;
            allowCommands = true;
          };

          config = builtins.readFile ../../../dotfiles/kmonad/config.kbd;
        };
      };
    };
  };
}
