{pkgs, config, ...}:

{
  xsession.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata_Classic";
    size = 24;
  };
}
