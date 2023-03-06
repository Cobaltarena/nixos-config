{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.languages.enable && config.profiles.languages.c_cpp;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      ccls
      clang-tools
      cmake
      gcc
      glibc
      glibc.dev
      gnumake
      stdenv.cc.cc.lib
    ];
  };
}
