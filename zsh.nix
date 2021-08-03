{config, lib, pkgs, ...}:

{

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;

  };
  
  programs.zsh.oh-my-zsh = {
    enable = true;
    plugins = [ "git" "sudo" "docker" ];
    theme = "gnzh";
  };
}
