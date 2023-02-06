{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.misc;
  # nvm = pkgs.stdenv.mkDerivation {
  #   name = "nvm-custom";
  #   src = pkgs.fetchFromGithub {
  #     owner = "nvm-sh";
  #     repo = "nvm";
  #     rev = "edacf8275e3bef4a80971625ed89df13a9af427c";
  #     sha256 = "ACYlHXDNkttHngnDDh8yRj48b4FdLtpF+vNnOIF4whI=";
  #   };
  #   buildInputs = [
  #     pkgs.git
  #     pkgs.bash
  #   ]
  #   phases = ''
  #     cp $src/install.sh .
  #     cat ./install.sh | bash
  #     exit .
  #   ''
  # };
in {
    options.my.packages.misc.enable = (mkEnableOption "Misc packages") // { default = true; };
  config = mkIf customCfg.enable {

    home.packages = with pkgs; [
      zlib
      rbenv
      (aspellWithDicts (dicts: with dicts; [ en en-computers en-science fr ]))
      docker
      docker-compose
      gnupg
      imagemagick
      numlockx
      podman
      pulseaudio
      stdenv.cc.cc.lib
      texlive.combined.scheme-full

      openssl_1_1
    ];
  };
}
