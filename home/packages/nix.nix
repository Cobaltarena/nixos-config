{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.nix;
in
{
  options.my.packages.nix.enable = (mkEnableOption "User Nix related packages") // { default = true; };

  config = mkIf customCfg.enable {
    home.packages = with pkgs; [
      nix-prefetch-git
      nix-prefetch-github
      nixpkgs-fmt
      rnix-lsp
    ];
  };
}
