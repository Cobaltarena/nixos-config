{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.yubikey;
in
{

  options.my.packages.yubikey.enable = (mkEnableOption "User Security Auth with yubico") // { default = true; };

  config = mkIf customCfg.enable {
    home.packages = with pkgs; [
      yubikey-manager-qt
      yubioath-flutter
    ];
  };

}
