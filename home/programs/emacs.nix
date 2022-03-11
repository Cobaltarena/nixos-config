{ pkgs, ...}:

{
  home.sessionVariables = {
    EDITOR = "emacsclient -t";
  };

  services.emacs = {
    enable = true;
    # generate emacsclient desktop file
    client.enable = true;
  };

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.vterm
    ];
  };
}
