{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.c_cpp;
in {
  options.my.packages.c_cpp.enable = (mkEnableOption "User C/C++ dev packages") // { default = false; };

  config = mkIf customCfg.enable {
    programs = {
      glib.dev.enable = true;
      glib.out.enable = true;
      llvm.enable = true;
    };

    home.packages = with pkgs; [
      ccls
      clang-tools
      cppcheck
      criterion
      gcc
    ];
  };
}
