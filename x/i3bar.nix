{ config, lib, pkgs, ... }:

{
  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        icons = "awesome5";
        settings = {
    	    theme = "solarized-dark";
            overrides = {
            };
        };
        blocks = [
          {
            block = "disk_space";
            path = "/";
            info_type = "available";
            format = "{icon} {used}/{total} | {available}";
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
          # {
          #   block = "bluetooth";
          #   mac = "58:A6:39:04:17:2B";
          #   hide_disconnected = true;
          #   format = "{label} Buds2";
          # }
          {
            block = "networkmanager";
            primary_only = true;
          }
          {
            block = "battery";
            interval = 10;
            good = 60;
            warning = 20;
            critical = 10;
            format = "{percentage}";
          }

          {
            block = "sound";
            driver = "pulseaudio";
            format = "{volume}";
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
