{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.languages.enable && config.profiles.languages.ruby;
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      ruby_3_1
      rubyPackages_3_1.rubocop
      rubyPackages_3_1.solargraph
      rubyPackages_3_1.syntax_tree-rbs
    ];

    programs.rbenv = {
      enable = true;
      enableZshIntegration = true;
      plugins = [
        {
          name = "ruby-build";
          src = pkgs.fetchFromGitHub {
            owner = "rbenv";
            repo = "ruby-build";
            rev = "f2c3a7f607b6c24edbf6f6b5953be15a6e2ef10c";
            sha256 = "bHdxlcLeOttKN/qcf3pI+UnLJdCawaeAvE1NxRWEqjs=";
          };
        }
      ];
    };
  };
}
