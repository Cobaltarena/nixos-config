{pkgs, config, environment, ...}:

{
  fonts.fontconfig.enable = true;
  

  imports = [
    ./packages.nix
    ./programs
  ];

  programs.home-manager.enable = true;

  
}
