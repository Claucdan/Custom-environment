{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.profont
    noto-fonts
  ];

  fonts.fontconfig.defaultFonts.monospace = [ "ProFontWindows Nerd Font Mono" ];

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    firefox
    grim
    hyprpaper
    hyprshot
    kitty
    mako
    playerctl
    slurp
    waybar
    wl-clipboard
    wofi
  ];
}
