{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.misc;
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
      pulseaudio
      stdenv.cc.cc.lib
      texlive.combined.scheme-full
      pdftk
      steam
      lutris
    ];
  };
}
