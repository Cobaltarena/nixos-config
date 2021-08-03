{pkgs, ...}:

{
  imports = [
    ./alacritty.nix
    ./i3.nix
    ./i3lock.nix
    ./zsh.nix
  ];
}
