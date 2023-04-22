{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.desktop.enable && config.profiles.desktop.rofi;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      meslo-lgs-nf
      rofi
    ];
    programs.rofi = {
      enable = true;
      terminal = "${pkgs.alacritty}/bin/alacritty";
      theme =
        let
          rofi-themes = pkgs.fetchFromGitHub {
            owner = "lr-tech";
            repo = "rofi-themes-collection";
            rev = "5ae9b23ef58893229b0df57ad750ad84801a632e";
            sha256 = "ecCQcDVWXpSilER99OROW9wutIq58llUGjFTn9rH2RM=";
          };
        in
        "${rofi-themes}/themes/squared-material-red.rasi";
      extraConfig = {
        show-icons = true;
        display-drun = "";
        drun-display-format = "{name}";
        sidebar-mode = false;
        width = 600;
        height = 325;
        font = "MesloLGS NF Regular 15";
        lines = 20;
        fake-transparency = true;
      };
    };
  };
}
