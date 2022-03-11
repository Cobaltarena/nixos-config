{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.packages.nix;
in {
  options.config.packages.nix = (mkEnableOption "User Nix related packages") // { default = false; };

  config= mkIf customCfg.enable {
    programs = {
      nix-linter.enable = true;
      nix-prefetch-git.enable = true;
      nix-prefetch-github.enable = true;
      nixpkgs-fmt.enable = true;
    };
  };
}
