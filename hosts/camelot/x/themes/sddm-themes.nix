{ pkgs, stdenv, fetchFromGitHub }:

{
  sddm-candy-sugar = stdenv.mkDerivation rec {
    pname = "sddm-candy-sugar-theme";
    version = "2.1";
    src = fetchFromGitHub {
      owner = "Cobaltarena";
      repo = "sddm-theme";
      rev = "c6629463b762431304b98b9eeda0af4a9c480c0a";
      sha256 = "WEHvd6dk3G18cgBjs1XNTAWg6MlSrB3gt9EMRJVrOCQ=";
    };

    propagatedBuildInputs = with pkgs; [
      libsForQt5.qt5.qtgraphicaleffects
    ];

    dontWrapQtApps = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/candy-sugar
    '';
  };
}
