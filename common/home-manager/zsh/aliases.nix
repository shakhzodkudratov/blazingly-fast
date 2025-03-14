{ ... }:
let
  cfg = {
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
    dotconf = "nvim $BLAZINGLY_FAST/dotfiles -c \"cd $BLAZINGLY_FAST/dotfiles\"";

    # nix related
    nixrebuild = "f() { git -C $BLAZINGLY_FAST add . && sudo nixos-rebuild switch --flake $BLAZINGLY_FAST --impure $1 }; f";
    nixpull = "git -C $BLAZINGLY_FAST pull";
    nixpush = "git -C $BLAZINGLY_FAST add . && git -C $BLAZINGLY_FAST commit -m 'automatically updated by nixupdate' && git -C $BLAZINGLY_FAST push";
    nixupgrade = "f() { nix flake update --flake $BLAZINGLY_FAST $1 && nixrebuild }; f";
    nixcleanup = "nix-env --delete-generations +2 && nix store gc && nix-channel --update && nix-env -u --always && nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration switch";
    # nix-shell = "nix-shell --run zsh";
    # nix-develop = "nix develop -c \"$SHELL\"";

    nix-shell-go = "nix-shell $NIX_SHELL_WORKSPACE/golang/latest/shell.nix";
  };
in
{
  config = {
    programs.zsh.shellAliases = cfg;
  };
}
