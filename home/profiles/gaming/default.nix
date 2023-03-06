{ config, lib, pkgs, ... }:

{
  config = (lib.mkIf config.profiles.gaming.enable && config.profiles.gaming.lutris {
    home.packages = with pkgs; [
      lutris
    ];
  }) // (lib.mkIf config.profiles.gaming.enable && config.profiles.gaming.steam {
    home.packages = with pkgs; [
      steam
    ];
  });
}
