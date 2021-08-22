{config, ...}:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    shellAliases = {
      "e" = "emacs";
      "wifi-connect" = "nmcli device wifi";
    };
    sessionVariables = {
      "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE"="fg=10";
    };
  };

  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" "sudo" "docker" ];
    theme = "gnzh";
  };
}
