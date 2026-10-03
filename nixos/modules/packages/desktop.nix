{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    firefox
    grim
    hyprpaper
    kitty
    mako
    slurp
    waybar
    wl-clipboard
    wofi
  ];
}
