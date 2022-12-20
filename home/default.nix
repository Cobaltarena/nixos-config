{ ... }:

{
  fonts.fontconfig.enable = true;
  imports = [
    ./packages
    ./programs
    ./x
  ];
  home.homeDirectory = "/home/gawain";
  home.stateVersion = "21.11";
  home.username = "gawain";
}
