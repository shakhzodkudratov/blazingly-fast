{ inputs, ... }: {
  nix-channels = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
    n2311 = import inputs.nixpkgs-2311 {
      system = final.system;
      config.allowUnfree = true;
    };
  };
  extra-packages = final: _prev: {
    kerio-control-vpnclient = import inputs.kerio-control-vpnclient {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
