{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.languages.enable && config.profiles.languages.js;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      nodejs
      nodePackages.pnpm
      nodePackages.typescript
      nodePackages.typescript-language-server
    ];
  };
}
