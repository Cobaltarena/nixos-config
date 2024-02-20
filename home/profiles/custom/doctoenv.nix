{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.custom.doctoenv.enable;
in
{
  config = lib.mkIf configOptionEnabled {
    ## REQUIRED PACKAGES
    home.packages = with pkgs; [

      # aws
      awscli
      aws-iam-authenticator
      aws-vault

      kubectl
      k9s
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
      postgresql_15
      postgresql_15.lib
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

    ];

    programs.zsh.initExtra = ''
      # Add condition if on darwin, /usr/bin is special and contain packages that cant be installed via nix
      export PATH=$PATH:/opt/homebrew/bin:

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
      export DOCTOLIB_KUBE_REPO=~/doctolib/kube
      export AWS_SDK_LOAD_CONFIG=true # Requirement for terraform and some other Go tools
      source $DOCTOLIB_KUBE_REPO/setup/scripts/k8s_access.sh
      
      export DOCTOLIB_STAGING_USE_ADMIN_ROLE=0
      export PKG_CONFIG_PATH="${pkgs.pixman}/lib/pkgconfig:${pkgs.cairo.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
      export PKG_CONFIG_PATH="${pkgs.pango.dev}/lib/pkgconfig:${pkgs.libpng.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
      export PKG_CONFIG_PATH="${pkgs.glib.dev}/lib/pkgconfig:${pkgs.harfbuzz.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"
      export PKG_CONFIG_PATH="${pkgs.freetype.dev}/lib/pkgconfig:$PKG_CONFIG_PATH"

      export DOCTOLIB_CLI_FS_TELEMETRY_ENABLED=false
      export DOCKER_HOST="unix://$HOME/.colima/default/docker.sock"
      export TESTCONTAINERS_DOCKER_HOST="$DOCKER_HOST"
      export TESTCONTAINERS_RYUK_DISABLED=true 
    '';
  };
}
