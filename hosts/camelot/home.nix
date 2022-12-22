{ config, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-15.5.2" # morgen
    ];
  };
  home-manager.users.gawain = {
    my.packages = {
      buildSystems.enable = true;
      c_cpp.enable = true;
      fonts.enable = true;
      js.enable = true;
      misc.enable = true;
      nix.enable = true;
      python.enable = true;
      terminal.enable = true;
      x.enable = true;
      yubikey.enable = true;
    };
  };
}
