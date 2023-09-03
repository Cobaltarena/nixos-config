{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.desktop.enable && config.profiles.desktop.x;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      arandr
      betterlockscreen
      bibata-cursors
      xautolock
      xfce.thunar
      xidlehook
      xsel
      xss-lock

    ];

    home.pointerCursor = {
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Amber";
      size = 24;
    };

    services.screen-locker = {
      enable = true;
      lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l";
      inactiveInterval = 30;
    };

  };
}
