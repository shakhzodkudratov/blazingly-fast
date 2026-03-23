{
  inputs,
  globalib,
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
        globalib
        isDarwin
        isLinux
        ;
    };
    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      inputs.sops.module
    ];
  };
}
