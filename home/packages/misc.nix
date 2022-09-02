{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.misc;
in {
    options.my.packages.misc.enable = (mkEnableOption "Misc packages") // { default = true; };
  config = mkIf customCfg.enable {
    programs = {
      mu.enable = true; # mail
    };

    home.packages = with pkgs; [
      docker
      docker-compose
      imagemagick
      numlockx
      postgresql
      pulseaudio
      qemu
      stdenv.cc.cc.lib
      texlive.combined.scheme-full
    ];
  };
}
