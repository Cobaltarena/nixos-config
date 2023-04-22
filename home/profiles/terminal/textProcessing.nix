{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.terminal.enable && config.profiles.terminal.textProcessing;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      bat
      jq
      yq
    ];
  };
}
