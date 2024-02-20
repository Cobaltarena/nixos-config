{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.profiles.editors.enable {
      home.packages = with pkgs; [
        (aspellWithDicts (dicts: with dicts; [ en en-computers en-science fr ]))
        meslo-lgs-nf
        ripgrep
      ];
      # programs.neovim.enable = true;
      programs.emacs = {
        enable = true;
      };
  };
}
