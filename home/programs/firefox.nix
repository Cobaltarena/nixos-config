{ config, pkgs, ... }:

{
  # TODO
  programs.firefox.enable = ! pkgs.stdenv.hostPlatform.isDarwin;
}
