{pkgs, config, ...}:

{
  xsession.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata Classic";
    size = 24;
  };
}
