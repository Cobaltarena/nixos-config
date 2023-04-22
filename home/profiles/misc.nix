{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    ncurses
    pandoc
    xclip
    texlive.combined.scheme-full
  ];
}
