{ config, lib, pkgs, ...}:

let
  mod = "Mod4";
  logoutMode = "[L]ogout, [S]uspend, [P]oweroff, [R]eboot";

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
        {
          command = "${pkgs.i3wsr}/bin/i3wsr --remove-duplicates";
          always = true;
          notification = true;
        }
        {
          command = "${pkgs.numlockx}/bin/numlockx on";
          always = true;
          notification = true;
        }
        {
          command = "${pkgs.betterlockscreen}/bin/betterlockscreen -u ~/.config/lockscreen.png";
          always = true;
          notification = true;
        }
        {
          command = "${pkgs.i3}/bin/i3 workspace number 1";
          always = true;
          notification = true;
        }
        {
          command = "${pkgs.xidlehook}/bin/xidlehook --not-when-fullscreen --not-when-audio --timer 240 'betterlockscreen -l' ''";
          always = true;
          notification = true;
        }
      ];

      bars =
        let
          barConfigPath =
            config.xdg.configFile."i3status-rust/config-top.toml".target;
        in
          [
            {
              statusCommand = "i3status-rs ${barConfigPath}";
              position = "top";
              fonts = {
                names = [ "DejaVuSansMono" "FontAwesome5Free" ];
                size = 9.0;
              };

              # disable mouse scroll wheel in bar
              extraConfig = ''
                bindsym button4 nop
                bindsym button5 nop
              '';
              colors = {

                background = "#000000";
                statusline = "orange";
                separator = "yellow";

                focusedWorkspace = {
                  border = "#2f343f";
                  background = "#8f3445";
                  text = "#d8dee8";
                };
                activeWorkspace = {
                  border = "#2f343f";
                  background = "#4ff4ff";
                  text = "#d8dee8";
                };
                inactiveWorkspace = {
                  border = "#2f343f";
                  background = "#2f343f";
                  text = "#d8dee8";
                };
                urgentWorkspace = {
                  border = "#2f343f";
                  background = "#ebcb8b";
                  text = "#2f343f";
                };
              };
            }
          ];

      colors = {
        focused = {
          background = "#8f3445";
          border = "#333333";
          text = "#ffffff";
          indicator = "#484e50";
          childBorder = "#8f3445";
        };

        focusedInactive = {
          background = "#6f1425";
          border = "#333333";
          text = "#ffffff";
          indicator = "#484e50";
          childBorder = "#6f1425";
        };
      };

      keybindings = lib.mkOptionDefault {
	      "${mod}+Return" = "exec alacritty";
	      "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show run";
        "${mod}+Tab" = "exec ${pkgs.rofi}/bin/rofi -show window";
        "${mod}+f" = "exec firefox";
        "${mod}+x" = "exec emacs";

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

        "${mod}+Shift+e" = ''mode "${logoutMode}"'';
	      "${mod}+Shift+r" = "restart";
        "${mod}+Shift+t" = "exec --no-startup-id betterlockscreen -l, mode default";

        "${mod}+Ctrl+Shift+Left" = "resize shrink width 5 px or 5 ppt";
        "${mod}+Ctrl+Shift+Down" = "resize grow height 5 px or 5 ppt";
        "${mod}+Ctrl+Shift+Up" = "resize shrink height 5 px or 5 ppt";
        "${mod}+Ctrl+Shift+Right" =  "resize grow width 5 px or 5 ppt";

        "XF86MonBrightnessUp" = "exec light -A 5";
        "XF86MonBrightnessDown" =  "exec light -U 5";

        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
      };

      modes =
        let
          makeModeBindings = attrs: attrs // {
            "Escape" = "mode default";
            "Return" = "mode default";
          };
        in
          lib.mkOptionDefault {
            "${logoutMode}" = makeModeBindings {
              "l" = "exec --no-startup-id i3-msg exit, mode default";
              "s" = "exec --no-startup-id betterlockscreen -l, mode default";
              "p" = "exec --no-startup-id systemctl poweroff, mode default";
              "r" = "exec --no-startup-id systemctl reboot, mode default";
            };
          };
    };
  };

}
