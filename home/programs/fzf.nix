{ config, pkgs, ...}:

{
  programs.fzf = {
    defaultOptions = [ "--height 40%" "--border" ];
    historyWidgetOptions = [ "--sort" "--exact" ];
  };
}
