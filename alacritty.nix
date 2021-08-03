{ config, lib, pkgs, ...}:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font.size = 12;
      background_opacity = 0.5;
      mouse.hide = true;
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
