{ pkgs, config, lib, inputs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "vscode"
    ];
    permittedInsecurePackages = [
      "qtwebkit-5.212.0-alpha4"
    ];
  };

  users.users.thomas = {
    name = "thomas";
    home = "/Users/thomas";
  };

  home-manager.users.thomas = {
    darwin = {
      installApps = true;
    };
    my.packages = {
      buildSystems.enable = true;
      c_cpp.enable = true;
      doctoenv.enable = true;
      fonts.enable = true;
      js.enable = true;
      misc.enable = true;
      nix.enable = true;
      python.enable = true;
      terminal.enable = true;
      x.enable = false;
      yubikey.enable = false; # not supported on darwin
    };
    # home.stateVersion = "23.05";
  };

}
