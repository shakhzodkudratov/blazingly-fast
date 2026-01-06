{
  pkgs,
  lib,
  ...
}:
let
  shared = {
    # top = "btop";
    # htop = "btop";
    cat = "bat";
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
  };
  linux = { };
  darwin = { };
in
lib.mkMerge [
  shared
  (lib.mkIf pkgs.stdenv.hostPlatform.isLinux linux)
  (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin darwin)
]
