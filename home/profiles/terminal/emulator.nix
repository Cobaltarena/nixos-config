{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.terminal.enable && config.profiles.terminal.terminalEmulator;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      alacritty
    ];

    programs.alacritty = {
      enable = true;
      settings = {
        font.size = 12;
        window_opacity = 0.5;
        mouse.hide = true;
        window.dynamic_title = true;
        key_bindings = [
          {
            key = "C";
            mods = "Alt";
            action = "Copy";
          }
          {
            key = "V";
            mods = "Alt";
            Action = "Paste";
          }
        ];
      };
    };
  };
}
