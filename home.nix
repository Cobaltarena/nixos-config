{pkgs, config, environment, ...}:

{
  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    #i3
    betterlockscreen
    font-awesome
    i3status-rust #i3bar
    i3wsr # rename workspace
    iw # ?
    pulseaudio # sound
    rofi

    # terminal
    alacritty

    # shell
    zsh
    zsh-autosuggestions
    oh-my-zsh

    # emacs
    emacs
    sqlite # org-roam

    #java
    gradle
    jetbrains.idea-ultimate
    maven

    # fonts
    meslo-lgs-nf
    
    # user needs
    acpilight
    docker
    discord
    imagemagick
    flameshot # screenshot
    htop
    lolcat
    neofetch
    mu # mail
    slack
  ];

  imports = [
    ./programs
  ];

  programs.home-manager.enable = true;

  
}
