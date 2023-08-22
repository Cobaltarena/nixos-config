{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.profiles.gaming.enable {
    home.packages = with pkgs; [
      amdvlk
      lutris
      protontricks
      steam
      vulkan-headers
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
      winetricks
      wineWowPackages.stable
    ];
  };
}
