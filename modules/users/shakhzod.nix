{
  lib,
  pkgs,
  modules,
  ...
} @ args: let
  user = "shakhzod";
  name = "Shakhzod Kudratov";
  email = "shakhzodkudratov@gmail.com";
in
  lib.mkMerge [
    {
      AstroNvim = {
        enable = true;
        username = user;
      };

      home-manager.users.${user} = lib.recursiveUpdate (modules.home-manager args) {
        programs.git = {
          settings.user = {
            inherit name email;
          };

          signing = {
            signByDefault = true;
            key = "5A1E1590CA201638ECCF834FD98C2DC59CFA95D4";
          };
        };
      };
    }

    # NixOS
    (lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
      users.users.${user} = {
        isNormalUser = true;
        description = "Shakhzod";
        extraGroups = ["networkmanager" "wheel" "docker"];
        shell = lib.getExe pkgs.zsh;
      };
    })

    # nix-darwin
    (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
      users.users.${user} = {
        name = "${user}";
        home = "/Users/${user}";
        isHidden = false;
        shell = pkgs.zsh;
      };

      # Fully declarative dock using the latest from Nix Store
      # local = {
      #   dock = {
      #     enable = true;
      #     entries = [
      #       {
      #         path = "/System/Applications/Messages.app/";
      #       }
      #       # { path = "${pkgs.alacritty}/Applications/Alacritty.app/"; }
      #     ];
      #   };
      # };
    })
  ]
