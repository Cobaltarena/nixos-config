{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.python;
in {
  options.my.packages.js.enable = (mkEnableOption "User Js/Ts dev packages") // { default = false; };

  config = mkIf customCfg.enable {
    home.packages = with pkgs; [
      nodejs-16_x
      nodePackages.pnpm
      nodePackages.typescript
      nodePackages.typescript-language-server
    ];
  };
}
