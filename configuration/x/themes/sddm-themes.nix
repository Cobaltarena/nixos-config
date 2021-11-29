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
      rev = "39cfa47c2292512ff117de64f0eaa12e2e383bca";
      sha256 = "JtwrftqWtQVBz5N/YRFpXp0kSONXESBxq69KFDmJOQc=";
    };
  };
}
