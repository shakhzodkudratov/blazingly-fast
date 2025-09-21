{
  astronvim-nix-nixos = import ./astronvim.nix/nix/nixos.nix;
  configurations = import ./configurations;
  home-manager = import ./home-manager;
  nix = import ./nix;
  packages = import ./packages;
  users = import ./users;
}
