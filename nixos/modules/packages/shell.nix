{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    atuin
    blesh
    direnv
    eza
    fd
    fzf
    ripgrep
    starship
    zoxide
  ];

  environment.etc."blesh/ble.sh".source = "${pkgs.blesh}/share/blesh/ble.sh";
}
