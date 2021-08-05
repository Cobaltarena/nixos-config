{pkgs, ...}:

{
  imports = [
    ./alacritty.nix
    ./i3.nix
    ./i3bar.nix
    ./zsh.nix
  ];
}
