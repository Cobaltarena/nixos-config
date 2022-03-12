{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.python;
in {
  options.my.packages.python.enable = (mkEnableOption "User Python dev packages") // { default = false; };

  config = mkIf customCfg.enable {
    home.packages = with pkgs; [
      python3
      python310Packages.black
      python310Packages.flake8
      python310Packages.isort
      python310Packages.pip
      python310Packages.python-lsp-server
    ];
  };
}
