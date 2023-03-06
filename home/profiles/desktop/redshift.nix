{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.desktop.enable && config.profiles.desktop.redshift;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      redshift
    ];

    services.redshift = {
      enable = true;
      settings = {
        redshift = {
          brightness-day = "1";
          brightness-night = "1";
        };
      };
      provider = "manual";
      latitude = 48.8534;
      longitude = 2.3488;
      temperature = {
        day = 5500;
        night = 3700;
      };
    };
  };

}
