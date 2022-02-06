{ config, lib, pkgs, ...}:

{
  services.screen-locker = {
    enable = true;
    lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l";
    inactiveInterval = 30;
  };
}
