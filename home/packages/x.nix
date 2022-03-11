{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.x;
in {
  options.my.packages.x.enable = (mkEnableOption "X related packages") // { default = false; };

  config = mkIf customCfg.enable {
    programs = {

      # bibata-cursors.enable = true; # cursor

      feh.enable = true;
      firefox.enable = true;
      i3status-rust.enable = true; #i3bar
      i3wsr.enable = true; # rename workspace
      imagemagick.enable = true; # image processing

      networkmanagerapplet.enable = true;

      redshift.enable = true; # night light
      rofi.enable = true; # dmenu replacement

      slack.enable = true;
      spotify.enable = true;
      teams.enable = true;
      thunderbird.enable = true;
      vscode.enable = true;
      xautolock.enable = true;

      xidlehook.enable = true;
      xsel.enable = true;
      xss-lock.enable = true;

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
    ];
  };
}
