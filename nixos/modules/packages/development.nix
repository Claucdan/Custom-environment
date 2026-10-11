{ codexPkgs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bash-language-server
    ccache
    clang
    clang-tools
    cmake
    cmake-language-server
    codexPkgs.codex
    gcc
    git
    gitui
    lua-language-server
    meson
    neovim
    nil
    ninja
    tree-sitter
    vim
    vscode
  ];

  virtualisation.podman.enable = true;

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
