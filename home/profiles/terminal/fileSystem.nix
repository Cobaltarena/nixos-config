{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.terminal.enable && config.profiles.terminal.fileSystem;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      direnv
      fzf
      fd
      tree
      zoxide
    ];
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    programs.fzf = {
      defaultOptions = [ "--height 40%" "--border" ];
      historyWidgetOptions = [ "--sort" "--exact" ];
    };
  };
}
