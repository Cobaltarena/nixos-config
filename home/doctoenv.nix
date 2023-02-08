{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.doctoenv;
in {

  options.my.packages.doctoenv.enable = (mkEnableOption "Available packages on nixpkgs required to have a working env") // { default = false; };

  config = mkIf customCfg.enable {
    ## REQUIRED PACKAGES
    home.packages = with pkgs; [

      # billing

      # aws
      awscli
      aws-vault

      # staging
      kubectl
      coreutils

      # env setup
      icu71
      openssl_1_1
      libsodium
      libyaml
      rustc # probably missing many things like rust-lldb
      cargo
      # wkhtmltopdf # dep not building

      cmake
      git
      graphviz
      postgresql

      # ruby lsp
      rubyPackages_3_1.solargraph

      # app
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
            rev = "a6976a5af32443ae0af41fa7713c6b1e8d629ed3";
            sha256 = "PYl6tMrOnr16z90XI56GO2/xhB1cenbxhXUFxF5gQdk=";
          };
        }
      ];
    };

    programs.zsh.initExtra = ''
      # Add condition if on darwin, /usr/bin is special and contain packages that cant be installed via nix
      # Docker binary isnt the exact same needed for macos
      export PATH=/usr/bin:/Applications/Docker.app/Contents/Resources/bin/:$PATH:/opt/homebrew/bin:

      # nvm
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
      [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

      # nix openssl_1_1 does not contain everything as opposed to openssl@1.1 from brew
      export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
        '';
  };
}
