{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.desktop.enable && config.profiles.desktop.discord;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      discord
    ];

    # TODO: add nix config for discord
  };
}
