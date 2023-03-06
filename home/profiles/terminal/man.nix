{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.terminal.enable && config.profiles.terminal.man;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      man-db
      man-pages
    ];
  };
}
