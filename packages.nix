{pkgs, ...}:

{
  home.packages = with pkgs; [
    alacritty # fast terminal
    betterlockscreen # i3lockscreen
    discord
    docker
    emacs
    flameshot # screenshot
    font-awesome # font and icon toolkit
    gradle # java build system
    htop # better top command
    i3status-rust #i3bar
    i3wsr # rename workspace
    imagemagick # image processing
    jetbrains.idea-ultimate
    lolcat
    maven # java build system
    meslo-lgs-nf # emacs font
    mu # mail
    neofetch
    oh-my-zsh
    pulseaudio # sound
    rofi # dmenu replacement
    slack
    sqlite # org-roam
    zsh
    zsh-autosuggestions
  ];

}
