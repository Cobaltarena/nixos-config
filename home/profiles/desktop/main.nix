{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.desktop.enable;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      evince
      gimp
      ncurses
      pavucontrol
    ];
  };
}
