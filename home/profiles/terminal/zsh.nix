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
in
{
  config = lib.mkIf configOptionEnabled {
    home.packages = with pkgs; [
      cod
      oh-my-zsh
      zsh-autosuggestions
      zsh-nix-shell

      fira
      font-awesome
      weather-icons
      unifont
      dejavu_fonts
      meslo-lgs-nf
    ];

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;

      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = "${pkgs.zsh-nix-shell}/share/zsh-nix-shell";
        }
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
        export PATH=$HOME/.custom/bin:/etc/profiles/per-user/$USER/bin:$PATH:
        eval "$(direnv hook zsh)"
        eval "$(zoxide init --hook pwd zsh)"
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
        source <(${pkgs.cod}/bin/cod init $$ zsh)
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
      ];
      theme = "gnzsh-nix";
    };
  };
}
