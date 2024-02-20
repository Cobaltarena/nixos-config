{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    cups
    pandoc
    xclip
    texlive.combined.scheme-full
  ];
}
