{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.custom.doctoenv.enable;
  dctl = pkgs.buildGoModule {
    name = "dctl";
    src = fetchGit {
      url = "git@github.com:doctolib/dctl";
      ref = "main";
      rev = "075fd8508d5daa010a5944133c6bc16ca7afbbf1";
    };
    vendorSha256 = "AeXdCRHnmM574WlzSA/pMr3GA+zItL2DCNxBoe+YcQg=";
    doCheck = false;
  };
in
{
  config = lib.mkIf configOptionEnabled {
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
      openssl_3
      libsodium
      libyaml
      rustc # probably missing many things like rust-lldb
      cargo
      pango.dev
      cairo.dev
      libpng.dev
      glib.dev
      harfbuzz.dev
      freetype.dev
      pixman

      cmake
      git
      graphviz
      postgresql
      postgresql.lib
      pkg-config
      libyaml
      # llvmPackages_14.llvm
      bison
      glib.dev
      glib.out
      zlib
      rbenv
      # stdenv.cc.cc.lib

      automake
      autoconf
      autoconf-archive
      libiconv

      # terraform
      terraform-ls

      gh
      cloudflared

      dctl
    ];

    programs.zsh.initExtra = ''
      # Add condition if on darwin, /usr/bin is special and contain packages that cant be installed via nix
      # Docker binary isnt the exact same needed for macos
      export PATH=$PATH:/usr/bin:/Applications/Docker.app/Contents/Resources/bin/:/opt/homebrew/bin:

      # nvm
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

      # nix openssl_1_1 does not contain everything as opposed to openssl@1.1 from brew
      # for some reason, I cant change the default system include path used by autotools for ruby dependencies
      # on top of that, the flags to specify the include dir and the lib dir does not seem to work through rbenv
      export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/opt/homebrew/opt/openssl@3 --with-libyaml-dir=/opt/homebrew/opt/libyaml --with-pg-include=$(brew --prefix libpq)/include --with-pg-lib=$(brew --prefix libpq)/lib"
      eval "$(rbenv init - zsh)"

      export DOCTOLIB_EMAIL=thomas.crambert@doctolib.com
      export DOCTOLIB_KUBE_REPO=~/Doctolib/kube
      export DOCTOLIB_STAGING_USE_ADMIN_ROLE=0
      export PKG_CONFIG_PATH="${pkgs.pixman}/lib/pkgconfig:${pkgs.cairo.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
      export PKG_CONFIG_PATH="${pkgs.pango.dev}/lib/pkgconfig:${pkgs.libpng.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
      export PKG_CONFIG_PATH="${pkgs.glib.dev}/lib/pkgconfig:${pkgs.harfbuzz.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
      export PKG_CONFIG_PATH="${pkgs.freetype.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"

      export DOCTOLIB_CLI_FS_TELEMETRY_ENABLED=false
    '';
  };
}
