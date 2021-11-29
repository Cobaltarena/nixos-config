{ config, pkgs, ...}:

let
  gnzsh-nix-theme = pkgs.fetchFromGitHub {
    owner =  "Cobaltarena";
    repo = "nix-gnzsh-theme";
    rev = "1aa07214ed0e2dba5cbb3fcb243733400a9e80a9";
    sha256 = "1gqhQBGmMNU6+1a4wAvYA8V3X5l4634p2g8ACONP6YA=";
  };

  customDir = pkgs.stdenv.mkDerivation {
    name = "oh-my-zsh-custom-dir";
    phases = [ "buildPhase" ];
    buildPhase = ''
      mkdir -p $out/themes
      echo ============================================
      echo $out
      echo ============================================
      cp ${gnzsh-nix-theme}/gnzsh-nix.zsh-theme $out/themes/gnzsh-nix.zsh-theme
    '';
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
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;

    plugins = [
      zsh-nix-shell
    ];

    sessionVariables = {
      "ZSH_DISABLE_COMPFIX"="true";
      "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE"="fg=10";
      "ALTERNATE_EDITOR"="";
      "VISUAL"="emacsclient -c -a 'emacs'";
      "EDITOR"="emacsclient -c -a 'emacs'";
    };

    shellAliases = {
      "emacs" = "emacsclient -c -a 'emacs'";
      "wifi-connect" = "nmcli device wifi";
      "gst"="git status";
      "ga"="git add";
      "gl"="git pull";
      "gp"="git push";
      "nix-regenv"=''echo "use nix" > .envrc; direnv allow'';
      "cat"=''bat --paging=never -f'';
    };

    initExtra = ''
      eval "$(direnv hook zsh)"
    '';
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    custom = "${customDir}";
    plugins = [
      "colored-man-pages"
      "git"
      "sudo"
      "history-substring-search"
    ];
    theme = "gnzsh-nix";
  };
}
