{ pkgs, ...}:

{

  home.packages = with pkgs; [
    alacritty # fast terminal
    bat # prettier cat
    bear
    betterlockscreen # i3lockscreen
    bibata-cursors # cursor
    binutils
    blueman
    bluez
    capitaine-cursors
    # clang
    cmake
    cppcheck
    criterion
    croc
    discord
    direnv
    docker
    docker-compose
    evince
    libclang.lib
    libtool
    feh
    firefox
    flameshot # screenshot
    font-awesome # font and icon toolkit
    gcc
    gimp
    glib.dev # vterm build
    glib.out # vterm build
    gnumake
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
    neofetch
    networkmanagerapplet
    nix-linter
    nix-prefetch-git
    nix-prefetch-github
    nixpkgs-fmt
    numlockx
    oh-my-zsh
    pandoc
    postgresql
    postman
    pulseaudio # sound
    python3
    redshift # night light
    rofi # dmenu replacement
    slack
    spotify
    sqlite # org-roam
    stdenv.cc.cc.lib # libstdc++
    texlive.combined.scheme-full
    tmux
    thunderbird
    tree
    unifdef
    unzip
    xautolock
    xclip
    xidlehook
    xsel
    xss-lock
    yamllint
    yq # prettier yaml
    zip
    zsh
    zsh-autosuggestions
  ];
}
