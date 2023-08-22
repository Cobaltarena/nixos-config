{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    cups
    ncurses
    pandoc
    xclip
    texlive.combined.scheme-full
  ];
}
