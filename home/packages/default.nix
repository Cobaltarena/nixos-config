{ config, lib, ... }:

{
  imports = [
    ./buildSystems.nix
    ./c_cpp.nix
    ./fonts.nix
    ./js.nix
    ./misc.nix
    ./nix.nix
    ./python.nix
    ./terminal.nix
    ./x.nix
    ./yubikey.nix
  ];
}
