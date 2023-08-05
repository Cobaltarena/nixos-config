{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.languages.enable && config.profiles.languages.js;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
    ];
  };
}
