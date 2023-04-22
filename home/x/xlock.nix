{ config, lib, pkgs, ... }:

{
  services.screen-locker = lib.mkIf config.my.packages.x.enable {
    enable = true;
    lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l";
    inactiveInterval = 30;
  };
}
