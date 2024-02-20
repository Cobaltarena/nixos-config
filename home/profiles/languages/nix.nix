{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.languages.enable && config.profiles.languages.nix;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      # nix-prefetch-git
      # nix-prefetch-github
      nixpkgs-fmt
      rnix-lsp
    ];
  };
}
