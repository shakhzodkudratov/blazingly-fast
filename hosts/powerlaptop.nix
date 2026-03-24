{
  inputs,
  glib,
  m,
}:
inputs.nix-darwin.lib.darwinSystem {
  specialArgs = {
    inherit inputs glib m;
    isDarwin = true;
    isLinux = false;
  };
  system = "aarch64-darwin";
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
