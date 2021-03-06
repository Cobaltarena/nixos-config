{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.buildSystems;
in {

  options.my.packages.buildSystems.enable = (mkEnableOption "User buildSystem packages") // { default = true; };

  config = mkIf customCfg.enable {
    home.packages = with pkgs; [
      gnumake
    ];
  };

}
