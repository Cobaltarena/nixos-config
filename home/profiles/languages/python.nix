{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.languages.enable && config.profiles.languages.python;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      python311
      python3Packages.black
      python3Packages.flake8
      python3Packages.isort
      python3Packages.mypy
      python3Packages.pip
      python3Packages.virtualenv

      python3Packages.python-lsp-server
      python3Packages.python-lsp-black
      # python3Packages.python-lsp-isort # TODO
    ];
  };
}
