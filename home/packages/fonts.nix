{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.fonts;
in {
  options.my.packages.fonts.enable = (mkEnableOption "User font packages") // { default = true; };

  config = mkIf customCfg.enable {
    home.packages = with pkgs; [
      fira
      fira-mono
      fira-code

      font-awesome # font and icon toolkit
      meslo-lgs-nf # emacs font
      roboto-mono

      hicolor-icon-theme # todo: move in theme.nix
    ];
  };
}
