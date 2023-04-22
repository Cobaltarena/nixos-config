{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.profiles.gaming.enable {
    home.packages = with pkgs; [
      amdvlk
      lutris
      steam
      vulkan-headers
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
      wineWowPackages.stable
    ];
  };
}
