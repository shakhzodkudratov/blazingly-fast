{
  inputs,
  ...
}:
{
  imports = [
    inputs.nmacs.homeManagerModules.nmacs
  ];

  services.nmacs.enable = true;
}
