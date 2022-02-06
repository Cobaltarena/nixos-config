{ pkgs, ...}:

{

  home.packages = with pkgs; [
    alacritty # fast terminal
    arandr
    bat # prettier cat
    bear # cdb
    betterlockscreen # i3lockscreen
    # bibata-cursors # cursor
    binutils
    blueman
    bluez # bluetooth
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
    exa # ls replacement ?
    leiningen
    libclang.lib
    libtool
    fd
    feh
    file
    firefox
    flameshot # screenshot
    font-awesome # font and icon toolkit
    fzf
    gcc
    git-lfs
    gimp
    glib.dev # vterm build
    glib.out # vterm build
    gnumake
    htop # better top command
    i3status-rust #i3bar
    i3wsr # rename workspace
    imagemagick # image processing
    openjdk17
    jdk17
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
    maven
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
    teams
    texlive.combined.scheme-full
    thunderbird
    tree
    unifdef
    unzip
    xautolock
    xclip
    xidlehook
    xsel
    xss-lock
    yamllint # yaml backend
    yq # prettier yaml
    zip
    zoxide
    zsh
    zsh-autosuggestions
    nix-zsh-completions
  ];
}
