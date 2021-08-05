{pkgs, ...}:

{
  home.packages = with pkgs; [
    #i3bar
    i3status-rust
    iw
    font-awesome
    pulseaudio
    
    # terminal
    alacritty

    # shell
    zsh
    zsh-autosuggestions
    oh-my-zsh

    # emacs
    emacs
    sqlite

    # user needs
    imagemagick
    docker
  ];

  imports = [
    ./programs
  ];

  programs.home-manager.enable = true;

}
