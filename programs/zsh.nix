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
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    plugins = [
      zsh-nix-shell
      nix-zsh-completions
    ];

    sessionVariables = {
      "ZSH_DISABLE_COMPFIX" = "true";
      "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE" = "fg=10";
      "ALTERNATE_EDITOR" = "";
      "VISUAL" = "emacsclient -c -a 'emacs'";
      "EDITOR" = "emacsclient -c -a 'emacs'";
      "_ZO_ECHO" = "1"; # 'When set to 1, z will print the matched directory before navigating to it.
      "_ZO_RESOLVE_SYMLINKS" = "1"; # When set to 1, z will resolve symlinks before adding directories to the database.
    };

    shellAliases = {
      "diff" = "diff -y --suppress-common-lines --color=always --width=105 -r -a";
      "emacs" = "emacsclient -c -a 'emacs'";
      "wifi-connect" = "nmcli device wifi";

      "gst" = "git status";
      "ga" = "git add";
      "gl" = "git pull";
      "gp" = "git push";
      "glog" = "git log --oneline --decorate --graph";

      "nix-regenv" =''echo "use nix" > .envrc; direnv allow'';

      "bat" = ''bat --paging=never -f'';

      "nixu" = "nix flake update";
      "nixc" = "nix flake check";
      "nixf" = "nix flake show";
      "nixd" = "nix flake develop";
    };

    initExtra = ''
      eval "$(direnv hook zsh)"
      eval "$(zoxide init --hook pwd zsh)"
    '';
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    custom = "${customDir}";
    plugins = [
      "colored-man-pages"
      "git"
    ];
    theme = "gnzsh-nix";
  };
}
