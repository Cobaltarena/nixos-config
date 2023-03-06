{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.desktop.enable && config.profiles.desktop.browser;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      firefox
    ];

    # TODO: add nix config for firefox
  };
}
