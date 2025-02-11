{ inputs, ... }: {
  imports = [inputs.e-imzo.nixosModules.e-imzo];

  services.e-imzo = {
    enable = true;
  };
}
