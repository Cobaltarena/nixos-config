{ config, lib, pkgs, ...}:

let
   mod = "Mod4";
in {
   xsession.scriptPath = ".hm-xsession";

   xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = mod;

        startup = [
        {
          command = "${pkgs.feh}/bin/feh --no-startup-id --bg-scale ~/.config/background.png";
          always = true;
          notification = true;
        }
        ];

	keybindings = lib.mkOptionDefault {
	  "${mod}+Return" = "exec alacritty";
	  "${mod}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
	  "${mod}+x" = "exec screenshot";
	  "${mod}+t" = "exec lockscreen";  

	  "${mod}+j" = "focus left";
	  "${mod}+i" = "focus down";	
	  "${mod}+k" = "focus up";
	  "${mod}+l" = "focus right";

	  "${mod}+Shift+j" = "move left";
	  "${mod}+Shift+i" = "move down";
	  "${mod}+Shift+k" = "move up";
	  "${mod}+Shift+l" = "move right";

	  "${mod}+1" = "workspace number 1";
	  "${mod}+2" = "workspace number 2";
	  "${mod}+3" = "workspace number 3";
	  "${mod}+4" = "workspace number 4";
	  "${mod}+5" = "workspace number 5";
	  "${mod}+6" = "workspace number 6";
	  "${mod}+7" = "workspace number 7";
	  "${mod}+8" = "workspace number 8";


	  "${mod}+Shift+1" = "move container to workspace number 1";
	  "${mod}+Shift+2" = "move container to workspace number 2";
	  "${mod}+Shift+3" = "move container to workspace number 3";
	  "${mod}+Shift+4" = "move container to workspace number 4";
	  "${mod}+Shift+5" = "move container to workspace number 5";
	  "${mod}+Shift+6" = "move container to workspace number 6";
	  "${mod}+Shift+7" = "move container to workspace number 7";
	  "${mod}+Shift+8" = "move container to workspace number 8";

	  "${mod}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes I want to go' 'i3-msg exit'";
	  "${mod}+Shift+r" = "restart";
    "${mod}+Shift+t" = "exec i3lock -i /home/gawain/.config/background.png";
	};
      };
   };

}
