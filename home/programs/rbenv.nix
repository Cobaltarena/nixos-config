{ config, lib, pkgs, ... }:
with lib;

let
  customCfg = config.my.programs.ruby;
in
{

  options.my.programs.ruby.enable = (mkEnableOption "Default terminal options") // { default = true; };

  config = mkIf customCfg.enable {
    programs.rbenv = {
      enable = true;
      enableZshIntegration = true;
      plugins = [
        {
          name = "ruby-build";
          src = pkgs.fetchFromGitHub {
            owner = "rbenv";
            repo = "ruby-build";
            rev = "a6976a5af32443ae0af41fa7713c6b1e8d629ed3";
            sha256 = "PYl6tMrOnr16z90XI56GO2/xhB1cenbxhXUFxF5gQdk=";
          };
        }
      ];
    };
  };
}
