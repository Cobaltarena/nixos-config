{ pkgs, config, lib, inputs, ... }:

{
    nixpkgs.config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };

    users.users.thomas = {
      name = "thomas";
      home = "/Users/thomas";
    };

    home-manager.users.thomas = {
      darwin = {
        installApps = true;
        fullCopies = true;
      };
      my.packages = {
        buildSystems.enable = true;
        c_cpp.enable = true;
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
