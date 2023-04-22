{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.terminal.enable && config.profiles.terminal.git;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      git
      git-lfs
      pre-commit
    ];
  };
}
