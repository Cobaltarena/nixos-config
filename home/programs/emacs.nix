{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.programs.emacs;
in {

  options.my.programs.emacs.enable = (mkEnableOption "Enable emacs") // { default = true; };

  # TODO: add overlay for emacs 29
  config = mkIf customCfg.enable {
    programs.emacs = {
      enable = true;
      extraPackages = epkgs: [
        epkgs.vterm
      ];
    };
  };
}
