{ pkgs, config, lib, inputs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "vscode"
    ];
    permittedInsecurePackages = [
      "qtwebkit-5.212.0-alpha4"
    ];
  };

  users.users.thomas = {
    name = "thomas";
    home = "/Users/thomas";
  };

  home-manager.users.thomas = {
    darwin = {
      installApps = false;
    };
    profiles = {
      desktop.enable = false;
      gaming.enable = false;

      custom.doctoenv.enable = true;

      editors.enable = true;

      languages = {
        enable = true;
        c_cpp = false;
        js = true;
        nix = true;
        python = false;
        ruby = true;
      };

      terminal = {
        enable = true;
        fileSystem = true;
        git = true;
        linuxTools = false;
        man = true;
        monitoring = true;
        terminalEmulator = false;
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
