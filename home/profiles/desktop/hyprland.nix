{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.desktop.enable && config.profiles.desktop.hyprland;
  wallpaper = "~/.config/nixpkgs/backgrounds/background.png";
in
{

  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      firefox-wayland
      grim
      mako
      slurp
      swaybg
      swayidle
      waybar
      wdisplays
      webcord
      wf-recorder
      wl-clipboard
      wl-mirror
      # wl-mirror-pick
      wofi
      wofi-emoji
    ];
    wayland.windowManager.hyprland = {
      enable = true;
      systemdIntegration = true;
      disableAutoreload = false;
      nvidiaPatches = false;
      extraConfig = ''
          # See https://wiki.hyprland.org/Configuring/Monitors/
          monitor=eDP-1, 1920x1080, 0x0, 1
          monitor=HDMI-A-0, 1920x1080, 1920x0, 1
monitor=,preferred,auto,1
          # See https://wiki.hyprland.org/Configuring/Keywords/ for more

          # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
          bind = SUPER, return, exec, ${pkgs.alacritty}/bin/alacritty
          bind = SUPER, X, exec, ${pkgs.emacs}/bin/emacs
          bind = SUPER, F, exec, ${pkgs.firefox}/bin/firefox
          bind = SUPER, D, exec, ${pkgs.wofi}/bin/wofi --show drun
          bind = SUPERSHIFT, Q, killactive,
          bind = SUPER, M, exit,
          bind = SUPER, V, togglefloating,
          bind = SUPER, P, pseudo, # dwindle
          bind = SUPER, J, togglesplit, # dwindle

          # Move focus with mainMod + arrow keys
          bind = SUPER, left, movefocus, l
          bind = SUPER, right, movefocus, r
          bind = SUPER, up, movefocus, u
          bind = SUPER, down, movefocus, d

          bind=SUPERSHIFT,left,movewindow,l
          bind=SUPERSHIFT,right,movewindow,r
          bind=SUPERSHIFT,up,movewindow,u
          bind=SUPERSHIFT,down,movewindow,d

          # Switch workspaces with mainMod + [0-9]
          bind = SUPER, 1, workspace, 1
          bind = SUPER, 2, workspace, 2
          bind = SUPER, 3, workspace, 3
          bind = SUPER, 4, workspace, 4
          bind = SUPER, 5, workspace, 5
          bind = SUPERCONTROL, 1, workspace, 6
          bind = SUPERCONTROL, 2, workspace, 7
          bind = SUPERCONTROL, 3, workspace, 8
          bind = SUPERCONTROL, 4, workspace, 9
          bind = SUPERCONTROL, 5, workspace, 10

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          bind = SUPERSHIFT, 1, movetoworkspace, 1
          bind = SUPERSHIFT, 2, movetoworkspace, 2
          bind = SUPERSHIFT, 3, movetoworkspace, 3
          bind = SUPERSHIFT, 4, movetoworkspace, 4
          bind = SUPERSHIFT, 5, movetoworkspace, 5
          bind = SUPERCONTROLSHIFT, 1, movetoworkspace, 6
          bind = SUPERCONTROLSHIFT, 2, movetoworkspace, 7
          bind = SUPERCONTROLSHIFT, 3, movetoworkspace, 8
          bind = SUPERCONTROLSHIFT, 4, movetoworkspace, 9
          bind = SUPERCONTROLSHIFT, 5, movetoworkspace, 10

          # Scroll through existing workspaces with mainMod + scroll
          bind = SUPER, mouse_down, workspace, e+1
          bind = SUPER, mouse_up, workspace, e-1

          # Move/resize windows with mainMod + LMB/RMB and dragging
          bindm = SUPER, mouse:272, movewindow
          bindm = SUPER, mouse:273, resizewindow

          # Keyboard controls (brightness, media, sound, etc)
          bind=,XF86MonBrightnessUp,exec,light -A 10
          bind=,XF86MonBrightnessDown,exec,light -U 10


          bind=,XF86AudioRaiseVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +5%
          bind=,XF86AudioLowerVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -5%
          bind=,XF86AudioMute,exec,pactl set-sink-mute @DEFAULT_SINK@ toggle

          # Screenshots
          bind=,Print,exec,grimblast --notify copy output
          bind=SHIFT,Print,exec,grimblast --notify copy active
          bind=CONTROL,Print,exec,grimblast --notify copy screen
          bind=SUPER,Print,exec,grimblast --notify copy window
          bind=ALT,Print,exec,grimblast --notify copy area

          input {
              kb_layout = us
              kb_variant =
              kb_model =
              kb_options =
              kb_rules =
              follow_mouse = 1
              touchpad {
                  natural_scroll = false
              }

              sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
          }

          general {
             # See https://wiki.hyprland.org/Configuring/Variables/ for more

             gaps_in = 1
             gaps_out = 1
             border_size = 2
             col.active_border = rgba(ff0000ee) rgba(ff0000ee) 45deg
             col.inactive_border = rgba(595959aa)

             layout = dwindle
          }


          # Startup
          exec-once=waybar
          exec=swaybg -i ${wallpaper} --mode fill
          exec-once=mako
          exec-once=swayidle -w

          decoration {
              # See https://wiki.hyprland.org/Configuring/Variables/ for more

              rounding = 5
              blur = false

              drop_shadow = true
              shadow_range = 4
              shadow_render_power = 3
              col.shadow = rgba(1a1a1aee)
          }

          animations {
              enabled = true

              # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

              bezier = myBezier, 0.05, 0.9, 0.1, 1.05

              animation = windows, 1, 7, myBezier
              animation = windowsOut, 1, 7, default, popin 80%
              animation = border, 1, 10, default
              animation = borderangle, 1, 8, default
              animation = fade, 1, 7, default
              animation = workspaces, 1, 6, default
          }

          dwindle {
              # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
              pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
              preserve_split = true # you probably want this
          }

          master {
              # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
              new_is_master = true
          }
          gestures {
              # See https://wiki.hyprland.org/Configuring/Variables/ for more
              workspace_swipe = false
          }

          # Example per-device config
          # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
          device:epic-mouse-v1 {
              sensitivity = -0.5
          }

          # Example windowrule v1
          # windowrule = float, ^(kitty)$
          # Example windowrule v2
          # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
          # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      '';
    };
  };
}
