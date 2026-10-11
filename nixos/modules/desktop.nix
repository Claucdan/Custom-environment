{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.hyprlock.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.displayManager.sessionPackages = [ pkgs.hyprland ];

  programs.throne.enable = true;
  programs.throne.tunMode.enable = true;
}
