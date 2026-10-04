{ pkgs, ... }:

let
  theme = pkgs.stdenvNoCC.mkDerivation {
    pname = "sddm-custom-environment";
    version = "1.0";
    src = ../../sddm;
    dontBuild = true;
    installPhase = ''
      runHook preInstall
      themeDir="$out/share/sddm/themes/custom-environment"
      mkdir -p "$themeDir"
      cp Main.qml metadata.desktop "$themeDir/"
      cp ${../../wallpapers/night_city.jpg} "$themeDir/background.jpg"
      cp ${../../wallpapers/kotost.png} "$themeDir/avatar.png"
      cp ${pkgs.nerd-fonts.profont}/share/fonts/truetype/NerdFonts/ProFont/ProFontWindowsNerdFontMono-Regular.ttf "$themeDir/font.ttf"
      runHook postInstall
    '';
  };
in
{
  system.build.sddmTheme = theme;
  environment.systemPackages = [ theme ];
  services.displayManager.sddm.theme = "custom-environment";
  services.displayManager.sddm.extraPackages = [ pkgs.qt6.qtimageformats ];
}
