{pkgs, config, ...}:

{
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    # deprecated, must wait for a fix
    # theme = "purple"
  };
}
