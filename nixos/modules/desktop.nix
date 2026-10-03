{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.displayManager.sessionPackages = [ pkgs.hyprland ];

  programs.throne.enable = true;
  programs.throne.tunMode.enable = true;
}
