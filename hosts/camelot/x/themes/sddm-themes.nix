{ stdenv, fetchFromGitHub }:
{
  sddm-candy-sugar = stdenv.mkDerivation rec {
    pname = "sddm-candy-sugar-theme";
    version = "2.1";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      echo ============================================
      echo $out
      echo ============================================
      cp -aR $src $out/share/sddm/themes/candy-sugar
      ls -la $out/share/sddm/themes
    '';
    src = fetchFromGitHub {
      owner = "Cobaltarena";
      repo = "sddm-theme";
      rev = "c29c8b4a84da66e87f874481f5c7d75562a93cce";
      sha256 = "j52RKk4r2LJHsCXXYJxyjTlwKabuXcI65bYMrLxN7Io=";
    };
  };
}
