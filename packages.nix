{ pkgs, ...}:

{

  home.packages = with pkgs; [
    alacritty # fast terminal
    bat # prettier cat
    bear
    betterlockscreen # i3lockscreen
    bibata-cursors # cursor
    binutils
    capitaine-cursors
    clang
    cmake
    criterion
    croc
    discord
    docker
    docker-compose
    libclang.lib
    libtool
    feh
    firefox
    flameshot # screenshot
    font-awesome # font and icon toolkit
    glib.dev # vterm build
    glib.out # vterm build
    htop # better top command
    i3status-rust #i3bar
    i3wsr # rename workspace
    imagemagick # image processing
    jetbrains.idea-ultimate
    jq # prettier json
    killall
    libclang
    libvterm-neovim
    llvm
    llvmPackages.libclang
    lolcat
    man-db
    man-pages
    meslo-lgs-nf # emacs font
    mu # mail
    ncurses # vterm build
    nixpkgs-fmt
    neofetch
    numlockx
    oh-my-zsh
    pandoc
    pulseaudio # sound
    python3
    ranger
    redshift # night light
    rofi # dmenu replacement
    slack
    sqlite # org-roam
    thunderbird
    xautolock
    xclip
    xidlehook
    xsel
    xss-lock
    yq # prettier yaml
    zsh
    zsh-autosuggestions
  ];

}
