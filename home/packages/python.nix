{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.python;
in
{
  options.my.packages.python.enable = (mkEnableOption "User Python dev packages") // { default = false; };

  config = mkIf customCfg.enable {
    home.packages = with pkgs; [

      python310
      python3Packages.black
      python3Packages.flake8
      python3Packages.isort
      python3Packages.mypy
      python3Packages.pip
      python3Packages.virtualenv

      python3Packages.python-lsp-server
      python3Packages.python-lsp-black
      #      python3Packages.python-lsp-isort
    ];
  };
}
