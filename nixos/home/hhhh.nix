{ config, lib, ... }:

let
  repo = "${config.home.homeDirectory}/Git/Custom-environment";
  configDirs = [
    "atuin"
    "gitui"
    "hypr"
    "kitty"
    "mako"
    "nvim"
    "waybar"
    "wofi"
  ];
in
{
  # Keep this at the version used when first enabling Home Manager.
  home.stateVersion = "26.05";

  xdg.enable = true;
  xdg.configFile = lib.genAttrs configDirs (name: {
    source = config.lib.file.mkOutOfStoreSymlink "${repo}/${name}";
  });
}
