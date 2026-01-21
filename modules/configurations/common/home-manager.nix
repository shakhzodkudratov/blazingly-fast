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
