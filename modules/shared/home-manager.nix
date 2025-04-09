{ config, pkgs, lib, ... }:

let name = "Shakhzod Kudratov";
    user = "shakhzod";
    email = "shakhzodkudratov@gmail.com"; in
{
  # Shared shell configuration
  zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];

    shellAliases = {
      # made with rust from orzklv/nix
      # top = "btop";
      # htop = "btop";
      # cat = "bat";
      ls = "eza";
      # sl = "eza";
      # ps = "procs";
      # grep = "rg";
      # search = "rg";
      # look = "fd";
      # find = "fd";
      # ping = "gping";
      # time = "hyperfine";

      zednix = "nohup zed --new --foreground . &";
      zn = "nohup zed --new --foreground . &";

      # configs
      nixconf = "nvim $BLAZINGLY_FAST -c \"cd $BLAZINGLY_FAST\"";

      # nix related
      # nixrebuild = "f() { git -C $BLAZINGLY_FAST add . && sudo nixos-rebuild switch --flake $BLAZINGLY_FAST --impure $1 }; f";
      nixpull = "git -C $BLAZINGLY_FAST pull";
      nixpush = "git -C $BLAZINGLY_FAST add . && git -C $BLAZINGLY_FAST commit -m 'automatically updated by nixupdate' && git -C $BLAZINGLY_FAST push";
      # nixupgrade = "f() { nix flake update --flake $BLAZINGLY_FAST $1 && nixrebuild }; f";
      # nixcleanup = "nix-env --delete-generations +2 && nix store gc && nix-channel --update && nix-env -u --always && nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration switch";

      nix-shell-go = "nix-shell $NIX_SHELL_WORKSPACE/golang/latest/shell.nix";
    };
  
    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Ripgrep alias
      alias search=rg -p --glob '!node_modules/*'  $@

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'

      export BLAZINGLY_FAST="$HOME/blazingly-fast"
      export NIX_SHELL_WORKSPACE="$HOME/dev/nix-shell-workspace"
    '';
  };

  zellij = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      theme = "gruvbox-hard";
      simplified_ui = true;
    };
  };

  git = {
    enable = true;
    userName = name;
    userEmail = email;
    lfs.enable = true;

    ignores = [
      ".idea"
      "node_modules"
      "*.swp"
    ];

    signing = {
      signByDefault = true;
      key = "5A1E1590CA201638ECCF834FD98C2DC59CFA95D4";
    };

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

  starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      battery.disabled = true;
    };
  };

  alacritty = {
    enable = true;
    settings = {
      cursor = {
        style = "Block";
      };

      window = {
        opacity = 1.0;
        padding = {
          x = 2;
          y = 2;
        };
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

  # ssh = {
  #   enable = true;
  #   includes = [
  #     (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
  #       "/home/${user}/.ssh/config_external"
  #     )
  #     (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
  #       "/Users/${user}/.ssh/config_external"
  #     )
  #   ];
  # };
}
