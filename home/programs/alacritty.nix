{ config, lib, pkgs, ...}:

{
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
}
