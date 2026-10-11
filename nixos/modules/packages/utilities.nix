{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    htop
    tree
    unzip
    wget
    zip
  ];
}
