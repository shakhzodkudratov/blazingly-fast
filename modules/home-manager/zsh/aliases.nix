{
  lib,
  pkgs,
  ...
}: let
  shared = {
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

    # zednix = "nohup zed --new --foreground . &";
    # zn = "nohup zed --new --foreground . &";

    # configs
    nixconf = "nvim $BLAZINGLY_FAST -c \"cd $BLAZINGLY_FAST\"";

    # nix related
    nixpull = "f() { cd $BLAZINGLY_FAST && git pull && cd -}; f || cd -";
    nixpush = "f() { cd $BLAZINGLY_FAST && git add . && git commit -m \"automatically updated by nixpush\" && git push && cd - }; f || cd -";

    nix-shell-go = "nix-shell $NIX_SHELL_WORKSPACE/golang/latest/shell.nix";
  };
  linux = {
    nixrebuild = "f() { git -C $BLAZINGLY_FAST add . && sudo nixos-rebuild switch --flake $BLAZINGLY_FAST --impure $1 }; f";
    nixupgrade = "f() { nix flake update --flake $BLAZINGLY_FAST $1 && nixrebuild }; f";
    nixcleanup = "nix-env --delete-generations +2 && nix store gc && nix-channel --update && nix-env -u --always && nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration switch";
  };
  darwin = {};
in
  shared // lib.linuxDarwinElse pkgs linux darwin {}
