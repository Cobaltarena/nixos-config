{ lib, ... }:

let
  generateOptions = import ./generateOption.nix;
in
import ./options.nix { inherit lib generateOptions; }

