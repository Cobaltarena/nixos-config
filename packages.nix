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
    # llvmPackages_13.clang
    ccls
    chromium
    clang-tools
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
    fd
    feh
    file
    fira
    fira-mono
    fira-code
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
    graphviz
    htop # better top command
    i3status-rust #i3bar
    i3wsr # rename workspace
    imagemagick # image processing
    openjdk17
    jdk17
    jetbrains.idea-ultimate
    jq # prettier json
    killall
    leiningen
    libvterm-neovim
    llvm
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
    pre-commit
    pulseaudio # sound
    python3
    python39Packages.pip
    qemu
    redshift # night light
    rofi # dmenu replacement
    roboto-mono
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
    vscode
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
