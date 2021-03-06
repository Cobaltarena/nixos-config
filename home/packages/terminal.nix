{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.terminal;
in {
  options.my.packages.terminal.enable = (mkEnableOption "User terminal util packages") // { default = false; };

  config = mkIf customCfg.enable {

    home.packages = with pkgs; [
      bat
      binutils
      direnv
      exa
      fd
      file
      fzf
      git-lfs
      graphviz
      htop
      jq
      killall
      man-db
      man-pages
      nix-zsh-completions
      ncurses
      oh-my-zsh
      pandoc
      pre-commit
      tree
      unzip
      xclip
      yq
      zip
      zoxide
      zsh-autosuggestions
    ];
  };
}
