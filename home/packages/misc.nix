{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.misc;
in {
    options.my.packages.misc.enable = (mkEnableOption "Misc packages") // { default = false; };
  config = mkIf customCfg.enable {
    programs = {
      libvterm-neovim.enable = true;
      mu.enable = true; # mail
      numlockx.enable = true;
      postgresql.enable = true;
      pulseaudio.enable = true; # sound
      qemu.enable = true;
      stdenv.cc.cc.lib.enable = true; # libstdc++
      texlive.combined.scheme-full.enable = true;
    };

    home.packages = with pkgs; [
      docker
      docker-compose
    ];
  };
}
