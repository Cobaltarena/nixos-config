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
      rev = "2b6546fcc83705469ec321e03492465af2c5f394";
      sha256 = "E2JSM00YZ0K81m+F/YdYR6olK5wUgwbvWKnZZJbTdZo=";
    };
  };
}
