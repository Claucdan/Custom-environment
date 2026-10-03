{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktop.nix
    ../../modules/hardware.nix
    ../../modules/packages
    ../../modules/system.nix
    ../../modules/users.nix
  ];

  networking.hostName = "nixos";

  # Keep this at the version used during the initial installation.
  system.stateVersion = "26.05";
}
