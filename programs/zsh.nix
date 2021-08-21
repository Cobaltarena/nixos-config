{config, lib, pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    shellAliases = {
      "e" = "emacs";
      "wifi-connect" = "nmcli device wifi";
    };
  };
  
  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" "sudo" "docker" ];
    theme = "gnzh";
  };
}
