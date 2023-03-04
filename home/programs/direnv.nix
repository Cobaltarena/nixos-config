{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.programs.direnv;
in
{
  options.my.programs.direnv.enable = (mkEnableOption "Direnv config") // { default = true; };

  config = mkIf customCfg.enable {
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    programs.direnv.nix-direnv.enableFlakes = true;
  };
}
