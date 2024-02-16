{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.desktop.enable && config.profiles.desktop.browser;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      firefox
      microsoft-edge
    ];

    # TODO: add nix config for firefox
  };
}
