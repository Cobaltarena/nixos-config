{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.programs.bluetooth;
in
{

  options.my.programs.bluetooth.enable = (mkEnableOption "Bluetooth options") // { default = false; };

  config = mkIf customCfg.enable {
    systemd.user.services.mpris-proxy = {
      Unit.Description = "Mpris proxy";
      Unit.After = [ "network.target" "sound.target" ];
      Service.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
      Install.WantedBy = [ "default.target" ];
    };
  };
}
