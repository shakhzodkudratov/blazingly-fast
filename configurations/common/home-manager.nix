{
  inputs,
  glib,
  m,
  isDarwin,
  isLinux,
  ...
}:
{
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {
      inherit
        inputs
        glib
        m
        isDarwin
        isLinux
        ;
    };
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      m.secrets
    ];
  };
}
