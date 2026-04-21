{
  inputs,
  glib,
  m,
}:
let
  system = "aarch64-darwin";
in
inputs.nix-darwin.lib.darwinSystem {
  specialArgs = {
    inherit inputs glib m;
    isDarwin = true;
    isLinux = false;
    pkgs-unstable = import inputs.nixpkgs-unstable {
      inherit system;
    };
  };
  inherit system;
  modules =
    m.configurations.common.__all
    ++ m.configurations.darwin.__all
    ++ [
      m.users.shakhzod
      (
        { ... }:
        {
          system = {
            stateVersion = 6;
            primaryUser = "shakhzod";
          };
        }
      )
    ];
}
