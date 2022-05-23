{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.python;
in {
  options.my.packages.python.enable = (mkEnableOption "User Python dev packages") // { default = false; };

  config = mkIf customCfg.enable {
    home.packages = with pkgs; [
      python3
      python39Packages.black
      python39Packages.flake8
      python39Packages.isort
      python39Packages.pip
      python39Packages.python-lsp-server
      python39Packages.virtualenv
    ];
  };
}
