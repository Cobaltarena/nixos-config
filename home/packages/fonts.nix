{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.fonts;
in {
  options.my.packages.fonts.enable = (mkEnableOption "User font packages") // { default = false; };

  config = mkIf customCfg.enable {
    home.packages = with pkgs; [
      fira
      fira-mono
      fira-code

      font-awesome # font and icon toolkit
      meslo-lgs-nf # emacs font
      roboto-mono
    ];
  };
}
