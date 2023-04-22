{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.desktop.enable && config.profiles.desktop.slack;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      slack
    ];
  };
}
