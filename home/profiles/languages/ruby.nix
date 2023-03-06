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
            rev = "4d2e1cc08f3e13c255a427551a2c43aa8caa7b67";
            sha256 = "/ZJZ6EAZOfk70yGXKJEvYDWSKAIwq8XSomcjd1hS/r0=";
          };
        }
      ];
    };
  };
}
