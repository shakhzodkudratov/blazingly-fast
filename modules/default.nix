{
  configurations = import ./configurations;
  home-manager = import ./home-manager;
  packages = import ./packages;
  custom = import ./custom;
  users = ./users;
}
