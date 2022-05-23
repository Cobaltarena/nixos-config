{ pkgs, lib, config, ...}:

{
  home.pointerCursor.x11 = lib.mkIf config.my.packages.x.enable {
    enable = true;
  };
  home.pointerCursor = lib.mkIf config.my.packages.x.enable {

    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Amber";
    size = 24;
  };
}
