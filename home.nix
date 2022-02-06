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
  home.stateVersion = "21.11";
  home.username = "gawain";
}
