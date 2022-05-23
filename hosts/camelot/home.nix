{ config, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home-manager.users.gawain = {
    my.packages = {
      buildSystems.enable = true;
      c_cpp.enable = true;
      fonts.enable = true;
      misc.enable = true;
      nix.enable = true;
      python.enable = true;
      terminal.enable = true;
      x.enable = true;
    };
  };
}
