{inputs, ...}: {
  home-manager = {
    useGlobalPkgs = true;
    sharedModules = [
      inputs.niri.homeModules.niri
    ];
  };
}
