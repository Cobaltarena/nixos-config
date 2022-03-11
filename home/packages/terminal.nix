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
      
      graphviz.enable = true;
      htop.enable = true;# better top command
      jq.enable = true; # prettier json
      killall.enable = true;
      man-db.enable = true;
      man-pages.enable = true;
      ncurses.enable = true; # vterm build
      neofetch.enable = true;
      oh-my-zsh.enable = true;
      pandoc.enable = true;
      pre-commit.enable = true;
      tree.enable = true;
      unzip.enable = true;
      xclip.enable = true;
      yq.enable = true; # prettier yaml
      zip.enable = true;
      zoxide.enable = true;
      zsh.enable = true;
      zsh-autosuggestions.enable = true;
      nix-zsh-completions.enable = true;
    };

    home.packages = with pkgs; [
      binutils
      fd
      file
      git-lfs
    ];
  };
}
