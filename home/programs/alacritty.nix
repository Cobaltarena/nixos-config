{ config, lib, pkgs, ...}:
with lib;

let
  customCfg = config.my.programs.terminal;
in {

  options.my.programs.terminal.enable = (mkEnableOption "Default terminal options") // { default = true; };

  config = mkIf customCfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        font.size = 14;
        window_opacity = 0.5;
        mouse.hide = true;
        window.dynamic_title = true;
        key_bindings = [
          {
            key = "C";
            mods = "Control|Alt";
            action = "Copy";
          }
          {
            key = "V";
            mods = "Control|Alt";
            action = "Paste";
          }
        ];
      };
    };
  };
}
