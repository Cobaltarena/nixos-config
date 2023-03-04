{ pkgs, lib, config, ... }:

{
  home.pointerCursor = lib.mkIf config.my.packages.x.enable {
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Amber";
    size = 24;
  };
}
