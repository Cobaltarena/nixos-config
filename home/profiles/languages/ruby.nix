{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.languages.enable && config.profiles.languages.ruby;
in
{
  config = lib.mkIf configOptionEnabled {
  };
}
