{ ... }:
let
  determinate-systems = "curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix";

  cfg = {
    # made with rust from orzklv/nix
    # top = "btop";
    # htop = "btop";
    # cat = "bat";
    # ls = "eza";
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
    avim = "NVIM_APPNAME=astronvim nvim";

    # configs
    zshrc = "avim $BLAZINGLY_FAST/home-manager/zsh/default.nix";
    avimconf = "avim $BLAZINGLY_FAST/home-manager/astronvim/user";
    nixconf = "avim $BLAZINGLY_FAST";

    eimzobin = "nix-shell -p jdk8 --run \"nohup java -jar $HOME/E-IMZO.jar &>/dev/null &\"";

    # nix related
    determinate = "${determinate-systems} | sh -s -- ";
    repair = "${determinate-systems} | sh -s -- repair";
    nixrebuild = "git -C $BLAZINGLY_FAST add . && sudo nixos-rebuild switch --flake $BLAZINGLY_FAST --impure";
    nixpull = "git -C $BLAZINGLY_FAST pull";
    nixpush = "git -C $BLAZINGLY_FAST add . && git -C $BLAZINGLY_FAST commit -m 'automatically updated by nixupdate' && git -C $BLAZINGLY_FAST push";
    nixupgrade = "sudo nix flake update $BLAZINGLY_FAST && nixrebuild";
    nixcleanup = "nix store gc && nix collect-garbage -d";
    nix-shell = "nix-shell --run zsh";
    nix-develop = "nix develop -c \"$SHELL\"";
    nix-shell-workspace = "nix-shell $NIX_SHELL_WORKSPACE";
  };
in
{
  config = {
    programs.zsh.shellAliases = cfg;
  };
}
