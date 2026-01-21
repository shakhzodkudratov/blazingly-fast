{
  pkgs,
  lib,
  modules,
  isLinux,
  isDarwin,
  ...
}:
let
  user = "shakhzod";
  name = "Shakhzod Kudratov";
  email = "shakhzodkudratov@gmail.com";
in
{
  config = lib.mkMerge [
    {
      sops.gnupg = {
        home = if isDarwin then "/Users/${user}/.gnupg" else "/home/${user}/.gnupg";
        sshKeyPaths = [ ];
      };

      home-manager.users.${user} = {
        imports = [ modules.home-manager ];

        sops.gnupg = {
          home = if isDarwin then "/Users/${user}/.gnupg" else "/home/${user}/.gnupg";
          sshKeyPaths = [ ];
        };

        programs.git = {
          settings.user = { inherit name email; };
          signing = {
            signByDefault = true;
            key = "5A1E1590CA201638ECCF834FD98C2DC59CFA95D4";
          };
        };
      };
    }

    (lib.mkIf isDarwin {
      users = {
        knownUsers = [ user ];
        users.${user} = {
          uid = 501;
          name = user;
          home = "/Users/${user}";
          isHidden = false;
          shell = pkgs.zsh;
        };
      };
    })

    (lib.mkIf isLinux {
      users.users.${user} = {
        isNormalUser = true;
        description = "Shakhzod";
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
        ];
        shell = lib.getExe pkgs.zsh;
      };
    })
  ];
}
