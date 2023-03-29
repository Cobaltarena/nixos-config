{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.profiles.editors.enable {
      home.packages = with pkgs; [
        (aspellWithDicts (dicts: with dicts; [ en en-computers en-science fr ]))
        meslo-lgs-nf
      ];
      # TODO: add overlay for emacs 29
      programs.emacs = {
        enable = true;
        extraPackages = epkgs: [
          epkgs.vterm
        ];
      };
  };
}
