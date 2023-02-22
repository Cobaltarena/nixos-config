{ config, lib, ... }:

{
  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "discord"
      "slack"
      "spotify"
      "steam"
      "steam-original"
      "steam-run"
      "teams"
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
