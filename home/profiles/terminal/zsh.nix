{ config, lib, pkgs, ... }:

let
  configOptionEnabled = config.profiles.terminal.enable && config.profiles.terminal.zsh;

  customTheme = pkgs.stdenv.mkDerivation {
    src = pkgs.fetchFromGitHub {
      owner = "Cobaltarena";
      repo = "nix-gnzsh-theme";
      rev = "1aa07214ed0e2dba5cbb3fcb243733400a9e80a9";
      sha256 = "1gqhQBGmMNU6+1a4wAvYA8V3X5l4634p2g8ACONP6YA=";
    };
    name = "oh-my-zsh-custom-dir";
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/themes
      cp $src/gnzsh-nix.zsh-theme $out/themes/gnzsh-nix.zsh-theme
    '';
  };

  nix-zsh-completions = {
    name = "nix-zsh-completions";
    src = pkgs.fetchFromGitHub {
      owner = "spwhitt";
      repo = "nix-zsh-completions";
      rev = "468d8cf752a62b877eba1a196fbbebb4ce4ebb6f";
      sha256 = "TWgo56l+FBXssOYWlAfJ5j4pOHNmontOEolcGdihIJs=";
    };
  };

  zsh-nix-shell = {
    name = "zsh-nix-shell";
    file = "nix-shell.plugin.zsh";
    src = pkgs.fetchFromGitHub {
      owner = "chisui";
      repo = "zsh-nix-shell";
      rev = "v0.1.0";
      sha256 = "0snhch9hfy83d4amkyxx33izvkhbwmindy0zjjk28hih1a9l2jmx";
    };
  };
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      oh-my-zsh
      zsh-autosuggestions
      # zsh-powerlevel10k

      fira
      font-awesome
      hicolor-icon-theme
      roboto-mono
      unifont
      material-design-icons
      emacsPackages.octicons
      emacs-all-the-icons-fonts
      weather-icons
      unifont
      nerdfonts
      gyre-fonts
      dejavu_fonts
      meslo-lgs-nf

      # TOCHECK
      # zsh-fzf-tab
      # zsh-forgit
      # zsh-you-should-use
      # zsh-syntax-highlighting
      # zsh-fast-syntax-highlighting
      # cod
    ];

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;

      plugins = [
        zsh-nix-shell
        nix-zsh-completions
        # {
        #   name = "powerlevel10k";
        #   src = pkgs.zsh-powerlevel10k;
        #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        # }
        # {
        #   name = "powerlevel10k-config";
        #   src = lib.cleanSource ./p10k-config;
        #   file = "p10k.zsh";
        # }
      ];

      sessionVariables = {
        "ZSH_DISABLE_COMPFIX" = "true";
        "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE" = "fg=10";
        "VISUAL" = "emacs";
        "EDITOR" = "emacs";
        "_ZO_ECHO" = "1"; # 'When set to 1, z will print the matched directory before navigating to it.
        "_ZO_RESOLVE_SYMLINKS" = "1"; # When set to 1, z will resolve symlinks before adding directories to the database.
      };

      shellAliases = {
        "diff" = "diff -y --suppress-common-lines --color=always --width=105 -r -a";

        "gst" = "git status";
        "ga" = "git add";
        "gl" = "git pull";
        "gp" = "git push";
        "glog" = "git log --oneline --decorate --graph";

        "nix-regenv" = ''echo "use nix" >> .envrc; direnv allow'';
        "nixf-regenv" = ''echo "use flake" >> .envrc; direnv allow'';
        "ls" = "ls --color";
      };

      initExtra = ''
        export PATH=/etc/profiles/per-user/$USER/bin:$PATH
        eval "$(direnv hook zsh)"
        eval "$(zoxide init --hook pwd zsh)"
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
        # export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
      '';
    };

    programs.zsh.oh-my-zsh = {
      enable = true;
      custom = "${customTheme}";
      plugins = [
        "branch"
        "colored-man-pages"
        "fzf"
        "git"
        "git-prompt"
      ];
      theme = "gnzsh-nix";
    };
  };
}