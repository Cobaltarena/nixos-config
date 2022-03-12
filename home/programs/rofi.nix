{pkgs, config, ...}:

let
  rofi-themes = pkgs.fetchFromGitHub {
    owner =  "lr-tech";
    repo = "rofi-themes-collection";
    rev = "5ae9b23ef58893229b0df57ad750ad84801a632e";
    sha256 = "ecCQcDVWXpSilER99OROW9wutIq58llUGjFTn9rH2RM=";
  };
in
{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "${rofi-themes}/themes/squared-material-red.rasi";
    extraConfig = {
      show-icons = true;
      display-drun = "";
      drun-display-format = "{name}";
      sidebar-mode = false;
      width = 500;
      height = 250;
      font = "MesloLGS NF Regular 15";
      lines = 15;
      fake-transparency = true;
    };
  };
}
