{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.terminal.enable && config.profiles.terminal.terminalEmulator;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      tmux
    ] ++ (if !pkgs.stdenv.isDarwin then [ pkgs.alacritty ] else []);

    programs.alacritty = {
	    enable = true;
	    settings = {
		    font.size = 14;
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
		    shell = { 
			    program = "${pkgs.tmux}/bin/tmux";
			    args = 
			    [
			    # find way to avoid hardcoding
				    "-f"  "/Users/crambert/.config/tmux/tmux.conf"
			    ]; 
		    };
	    };      
    };
    programs.tmux = {
	    enable = true;
	    sensibleOnTop = false;
	    terminal = "screen-256color";
             baseIndex= 1; 
	    historyLimit = 10000000;
	    mouse = true;
    };
  };
}
