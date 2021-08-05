{ config, lib, pkgs, ... }:

{
  programs.i3status-rust = {
    enable = true;

    bars = {
      top = {
        icons = "awesome5";

        blocks = [
          {
            block = "docker";
            interval = 2;
            format = "{running/total}";
          }
          {
            block = "pomodoro";
            length = 45;
            break_length = 10;
          }
          {
            block = "disk_space";
            path = "/";
            alias = "/";
            info_type = "available";
            unit = "GB";
            interval = 60;
            warning = 20.0;
            alert = 10.0;
          }
          {
            block = "memory";
            display_type = "memory";
            format_mem = "{mem_used;G}/{mem_total;G}";
            warning_mem = 70.0;
            critical_mem = 90.0;
            # don't show swap
            clickable = false;
          }
          {
            block = "cpu";
            interval = 1;
            format = "{barchart}";
          }
          {
            block = "battery";
            interval = 10;
            format = "{percentage} {time}";
          }
          {
            block = "networkmanager";
            primary_only = true;
          }
          {
            block = "sound";
            driver = "pulseaudio";
            format = "{output_description} {volume}";
          }
          {
            block = "keyboard_layout";
            driver = "setxkbmap";
            interval = 15;
          }
          {
            block = "time";
            interval = 5;
            format = "%a %d/%m %T";
            locale = "fr_FR";
            timezone = "Europe/Paris";
          }
        ];
      };
    };
  };
}
