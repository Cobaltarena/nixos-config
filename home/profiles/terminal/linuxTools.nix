{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.terminal.enable && config.profiles.terminal.linuxTools;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      # binutils
      coreutils
      file
      gnugrep
      gnused
      killall
      unzip
      zip
    ];
  };
}
