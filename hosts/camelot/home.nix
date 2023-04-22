{ lib, ... }:

{

  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "discord"
      "slack"
      "spotify"
      "steam"
      "steam-original"
      "steam-run"
      "teams"
    ];
  };
  home-manager.users.gawain = {
    profiles = {
      desktop = {
        enable = true;
        browser = true;
        discord = true;
        i3 = true;
        hyprland = true;
        redshift = true;
        rofi = true;
        slack = true;
        x = true;
      };
      gaming = {
        enable = true;
        lutris = true;
        steam = true;
      };

      editors.enable = true;

      languages = {
        enable = true;
        c_cpp = true;
        js = true;
        nix = true;
        python = true;
        ruby = true;
      };

      terminal = {
        enable = true;
        fileSystem = true;
        git = true;
        linuxTools = true;
        man = true;
        monitoring = true;
        terminalEmulator = true;
        textProcessing = true;
        zsh = true;
      };
      system = {
        # TODO
        enable = false;
      };
    };
  };
}
