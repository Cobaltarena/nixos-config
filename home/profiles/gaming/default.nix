{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.profiles.gaming.enable {
    home.packages = with pkgs; [
      vulkan-tools
      vulkan-loader
      vulkan-headers
      amdvlk
      vulkan-validation-layers
      lutris
      steam
    ];
  };
}
