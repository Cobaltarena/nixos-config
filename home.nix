{ pkgs, config, ...}:

{
  fonts.fontconfig.enable = true;


  imports = [
    ./packages.nix
    ./programs
    ./x
  ];

  programs.home-manager.enable = true;

  home.homeDirectory = "/home/gawain";
  home.stateVersion = "21.05";
  home.username = "gawain";

}
