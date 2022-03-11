{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.x;
in {
  options.my.packages.x.enable = (mkEnableOption "X related packages") // { default = true; };

  config = mkIf customCfg.enable {
    programs = {

      # bibata-cursors.enable = true; # cursor

      feh.enable = true;
      firefox.enable = true;
      i3status-rust.enable = true; #i3bar
      rofi.enable = true; # dmenu replacement
    };

    home.packages = with pkgs; [
      arandr
      betterlockscreen # i3lockscreen
      blueman
      bluez
      discord
      evince
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
