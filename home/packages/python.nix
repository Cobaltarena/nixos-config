{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.packages.python;
in {
  options.config.packages.python = (mkEnableOption "User Python dev packages") // { default = false; };

  config = mkIf customCfg.enable {
    programs = {
      python3.enable = true;
      python310Packages.black.enable = true;
      python310Packages.flake8.enable = true;
      python310Packages.isort.enable = true;
      python310Packages.pip.enable = true;
      python310Packages.python-lsp-server.enable = true;
    };
  };
}
