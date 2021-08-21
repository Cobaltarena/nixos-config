{pkgs, ...}:

{
  imports = [
    ./alacritty.nix
    ./i3.nix
    ./i3bar.nix
    ./redshift.nix
    ./rofi.nix
    ./zsh.nix
  ];
}
