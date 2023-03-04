{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.c_cpp;
in
{
  options.my.packages.c_cpp.enable = (mkEnableOption "User C/C++ dev packages") // { default = true; };

  config = mkIf customCfg.enable {
    home.packages = with pkgs; [
      ccls
      clang-tools
      cppcheck
      # gcc
      glib.dev
      glib.out
    ];
  };
}
