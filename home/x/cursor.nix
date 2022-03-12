{ pkgs, lib, config, ...}:

{
  xsession.pointerCursor = lib.mkIf config.my.packages.x.enable {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Amber";
    size = 24;
  };
}
