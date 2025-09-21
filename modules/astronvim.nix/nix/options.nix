{lib, ...}: {
  options.AstroNvim = with lib; {
    enable = mkEnableOption "Enable astronvim.nix";
    username = mkOption {
      type = types.str;
      description = "The user for whom astronvim.nix will be installed";
    };
  };
}
