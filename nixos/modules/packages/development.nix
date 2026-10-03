{ codexPkgs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    clang
    cmake
    codexPkgs.codex
    gcc
    git
    gitui
    meson
    neovim
    ninja
    tree-sitter
    vim
  ];

  systemd.user.services.codex-background-server = {
    description = "Codex background app server";
    wantedBy = [ "default.target" ];
    unitConfig.ConditionUser = "hhhh";
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/codex app-server --listen unix://";
      WorkingDirectory = "%h";
      Restart = "on-failure";
      RestartSec = 3;
    };
  };
}
