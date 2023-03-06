{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.profiles.editors.enable && config.profiles.editors.emacs
    {
      home.packages = with pkgs; [
        (aspellWithDicts (dicts: with dicts; [ en en-computers en-science fr ]))
        emacs
        meslo-lgs-nf
      ];
      # TODO: add overlay for emacs 29
      programs.emacs = {
        enable = true;
        extraPackages = epkgs: [
          epkgs.vterm
        ];
      };
    } // lib.mkIf config.profiles.editors.enable && config.profiles.editors.vscode {
    # TODO
    home.packages = with pkgs; [
      vscode
    ];
  };
}
