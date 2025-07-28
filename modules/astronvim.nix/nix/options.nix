{lib, ...}: {
  options.AstroNvim = with lib; {
    username = mkOption {
      type = types.str;
      description = "The user for whom astronvim.nix will be installed";
    };
  };
}
