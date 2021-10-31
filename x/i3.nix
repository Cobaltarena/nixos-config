{ config, pkgs, ...}:

{
  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
     enable = true;
     desktopManager = {
        xterm.enable = false;
     };

     displayManager = {
        defaultSession = "none+i3";
     };

     libinput = {
       enable = true;
       touchpad.disableWhileTyping = true;
     };

     windowManager.i3 = {
        enable = true;
	      extraPackages = with pkgs; [
	        dmenu
	        i3status
	        i3lock
	        i3blocks
	      ];
     };

     resolutions = [{ x = 1920; y = 1080; }];

  };
}
