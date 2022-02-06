{ environment, config, pkgs, ...}:

let
  sddmTheme = pkgs.callPackage ./themes/sddm-themes.nix { };
in
{
  environment.systemPackages = with pkgs; [
    sddmTheme.sddm-candy-sugar
  ];
  services.xserver.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    theme = "candy-sugar";
    autoNumlock = true;
  };
}
