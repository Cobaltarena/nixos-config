{pkgs, ...}:

{
  home.packages = with pkgs; [
    #i3
    betterlockscreen
    font-awesome
    i3status-rust #i3bar
    iw # ?
    pulseaudio # sound
    # xorg.xbacklight # brigthness

    # terminal
    alacritty

    # shell
    zsh
    zsh-autosuggestions
    oh-my-zsh

    # emacs
    emacs
    sqlite # org-roam

    # user needs
    acpilight
    docker
    discord
    imagemagick
    flameshot # screenshot
    lolcat
    mu # mail
    slack
  ];

  imports = [
    ./programs
  ];

  programs.home-manager.enable = true;

}
