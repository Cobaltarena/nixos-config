{config, pkgs, ...}:
let

  agnoster-nix-theme = builtins.fetchurl {
    url = "https://gist.githubusercontent.com/chisui/0d12bd51a5fd8e6bb52e6e6a43d31d5e/raw/a97b74ce17c5f1befabe266ccf02a972cab2911b/agnoster-nix.zsh-theme";
    sha256 = "1m7qqrp8z0glnq81c9ldzmm0r42rgdmw8nk9hvssbjphx5khk6z7";
  };

  customDir = pkgs.stdenv.mkDerivation {
    name = "oh-my-zsh-custom-dir";
    phases = [ "buildPhase" ];
    buildPhase = ''
      mkdir -p $out/themes
      cp ${agnoster-nix-theme} $out/themes/agnoster-nix.zsh-theme
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
    initExtra = ''
        eval "$(direnv hook zsh)"
          '';

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.4.0";
          sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
        };
      }
    ];

    sessionVariables = {
      "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE"="fg=10";
      "EDITOR"="vim";
    };

    shellAliases = {
      "e" = "emacs";
      "wifi-connect" = "nmcli device wifi";
      "gst"="git status";
      "ga"="git add";
      "gl"="git log";
      "gp"="git pull";
      "nix-regenv"=''echo "use nix" > .envrc; direnv allow'';
    };
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    custom = "${customDir}";
    plugins = [
      "docker"
      "git"
      "sudo"
    ];
    theme = "agnoster-nix";
  };
}
