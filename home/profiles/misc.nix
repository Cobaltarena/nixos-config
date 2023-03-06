{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ncurses
    pandoc
    xclip
  ];
}
