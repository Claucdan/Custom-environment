{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    tree
    unzip
    wget
    zip
  ];
}
