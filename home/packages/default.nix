{ config, lib, ... }:

with lib;
let
  cfg = config.services.packages;
in
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
  ];
}
