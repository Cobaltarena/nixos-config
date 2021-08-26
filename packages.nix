{ pkgs, ...}:

{

  home.packages = with pkgs; [
    alacritty # fast terminal
    betterlockscreen # i3lockscreen
    bibata-cursors # cursor
    bpytop
    capitaine-cursors
    cmake
    discord
    docker
    libtool
    firefox
    flameshot # screenshot
    font-awesome # font and icon toolkit
    gcc
    glib.dev # vterm build
    glib.out # vterm build
    gradle # java build system
    htop # better top command
    i3status-rust #i3bar
    i3wsr # rename workspace
    imagemagick # image processing
    jetbrains.idea-ultimate
    libvterm-neovim # vterm build
    llvm
    lolcat
    maven # java build system
    meslo-lgs-nf # emacs font
    mu # mail
    ncurses # vterm build
    neofetch
    numlockx
    oh-my-zsh
    pandoc
    pulseaudio # sound
    python3
    redshift # night light
    rofi # dmenu replacement
    slack
    sqlite # org-roam
    thunderbird
    zsh
    zsh-autosuggestions
  ];

}
