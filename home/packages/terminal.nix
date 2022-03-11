{ config, lib, pkgs, ... }:

with lib;

let
  customCfg = config.my.packages.terminal;
in {
  options.my.packages.terminal.enable = (mkEnableOption "User terminal util packages") // { default = false; };

  config = mkIf customCfg.enable {
    programs = {
      alacritty.enable = true; # terminal
      bat.enable = true; # prettier cat
      direnv.enable = true;
      exa.enable = true; # ls replacement ?

      fzf.enable = true;
      htop.enable = true;# better top command
      jq.enable = true; # prettier json
      pandoc.enable = true;
      zsh.enable = true;
    };

    home.packages = with pkgs; [
      binutils
      fd
      file
      git-lfs
      graphviz
      killall
      man-db
      man-pages
      ncurses
      nix-zsh-completions
      oh-my-zsh
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
