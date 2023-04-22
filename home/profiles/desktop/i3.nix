{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
  logoutMode = "[L]ogout, [S]uspend, [P]oweroff, [R]eboot";
  configOptionEnabled = config.profiles.desktop.enable && config.profiles.desktop.i3;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      betterlockscreen
      feh
      firefox
      flameshot
      i3status-rust
      i3wsr
      networkmanagerapplet
      numlockx
      rofi
    ];

    xsession.scriptPath = ".hm-xsession";

    xsession.windowManager.i3 = {
      enable = true;
      config = {
        modifier = mod;

        startup = [
          {
            command = "${pkgs.networkmanagerapplet}/bin/nm-applet";
            always = true;
            notification = true;
          }
          {
            command = "${pkgs.feh}/bin/feh --no-startup-id --bg-scale ~/.config/nixpkgs/backgrounds/background.png";
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
            command = "${pkgs.betterlockscreen}/bin/betterlockscreen -u ~/.config/nixpkgs/backgrounds/lockscreen.png";
            always = true;
            notification = true;
          }
          {
            command = "${pkgs.xidlehook}/bin/xidlehook --not-when-fullscreen --not-when-audio --timer 240 'betterlockscreen -l' ''";
            always = true;
            notification = true;
          }
          {
            command = "${pkgs.flameshot}/bin/flameshot";
            always = true;
            notification = true;
          }
        ];

        bars =
          [
            {
              workspaceNumbers = false;
              statusCommand = "i3status-rs ~/.config/i3status-rust/config-top.toml";
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

                # background = "#6a6a6a";

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
                  border = "#6a6a6a";
                  background = "#6a6a6a";
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
          "${mod}+Shift+f" = "fullscreen toggle";
          "${mod}+x" = "exec emacs";

          "${mod}+1" = "workspace number 1:(1)";
          "${mod}+2" = "workspace number 2:(2)";
          "${mod}+3" = "workspace number 3:(3)";
          "${mod}+4" = "workspace number 4:(4)";
          "${mod}+5" = "workspace number 5:(5)";
          "${mod}+Ctrl+1" = "workspace number 6:(C1)";
          "${mod}+Ctrl+2" = "workspace number 7:(C2)";
          "${mod}+Ctrl+3" = "workspace number 8:(C3)";
          "${mod}+Ctrl+4" = "workspace number 9:(C4)";
          "${mod}+Ctrl+5" = "workspace number 10:(C5)";


          "${mod}+Shift+1" = "move container to workspace number 1:(1)";
          "${mod}+Shift+2" = "move container to workspace number 2:(2)";
          "${mod}+Shift+3" = "move container to workspace number 3:(3)";
          "${mod}+Shift+4" = "move container to workspace number 4:(4)";
          "${mod}+Shift+5" = "move container to workspace number 5:(5)";
          "${mod}+Ctrl+Shift+1" = "move container to workspace number 6:(C1)";
          "${mod}+Ctrl+Shift+2" = "move container to workspace number 7:(C2)";
          "${mod}+Ctrl+Shift+3" = "move container to workspace number 8:(C3)";
          "${mod}+Ctrl+Shift+4" = "move container to workspace number 9:(C4)";
          "${mod}+Ctrl+Shift+5" = "move container to workspace number 10:(C5)";

          "${mod}+Shift+e" = ''mode "${logoutMode}"'';
          "${mod}+Shift+r" = "restart";

          "${mod}+Ctrl+Shift+Left" = "resize shrink width 5 px or 5 ppt";
          "${mod}+Ctrl+Shift+Down" = "resize grow height 5 px or 5 ppt";
          "${mod}+Ctrl+Shift+Up" = "resize shrink height 5 px or 5 ppt";
          "${mod}+Ctrl+Shift+Right" = "resize grow width 5 px or 5 ppt";

          "${mod}+F1" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "${mod}+F2" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "${mod}+F3" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
          "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
          "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";

          "${mod}+F5" = "exec light -U 5";
          "${mod}+F6" = "exec light -A 5";

          "${mod}+Shift+P" = "exec flameshot gui";

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

    programs.i3status-rust = {
      enable = true;
      bars.top = {
        icons = "awesome5";
        theme = "solarized-dark";
        blocks = [
        {
          block = "disk_space";
          path = "/";
          info_type = "available";
          format = " $icon $used/$total | $available ";
          # unit = "GB";
          interval = 60;
          warning = 20.0;
          alert = 10.0;
        }
        {
        block = "memory";
        format = " $icon $mem_used/$mem_total ";
        warning_mem = 70.0;
        critical_mem = 90.0;
        # don't show swap
        # clickable = false;
        }
        {
          block = "cpu";
          interval = 1;
          format = " $barchart $utilization ";
        }
        {
          block = "net";
          format = " $icon $ip $device ";
        }
        {
          block = "battery";
          interval = 10;
          good = 40;
          warning = 20;
          critical = 10;
          format = " $icon $percentage {$time, $power W} ";
        }
        {
          block = "sound";
          driver = "pulseaudio";
          format = " $icon $volume ";
        }
        {
          block = "time";
          interval = 5;
          format = " $icon $timestamp.datetime(f:'%a %d/%m %T', l:fr_FR) ";
          timezone = "Europe/Paris";
        }
        ];
      };
    };
  };
}
