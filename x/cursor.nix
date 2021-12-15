{pkgs, config, ...}:

{
  xsession.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    # package = pkgs.gnome.adwaita-icon-theme;
    # name = "Adwaita";
    size = 24;
  };
}
