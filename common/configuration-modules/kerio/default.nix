{ inputs, ... }: {
  imports = [inputs.kerio.nixosModules.kerio];

  services.kerio-kvc = {
    enable = true;
  };
}
