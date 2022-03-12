{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.x;
in {
  options.my.packages.x.enable = (mkEnableOption "X related packages") // { default = true; };

  config = mkIf customCfg.enable {
    home.packages = with pkgs; [
      arandr
      betterlockscreen # i3lockscreen
      bibata-cursors
      blueman
      bluez
      discord
      evince
      feh
      flameshot
      gimp
      i3wsr # rename workspace dynamically
      imagemagick
      networkmanagerapplet
      redshift
      slack
      spotify
      teams
      thunderbird
      vscode
      xautolock
      xidlehook
      xsel
      xss-lock
    ];
  };
}
