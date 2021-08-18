{config, lib, pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    shellAliases = {
      "wifi-connect" = "nmcli device wifi";
    };
  };
  
  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" "sudo" "docker" ];
    theme = "gnzh";
  };
}
