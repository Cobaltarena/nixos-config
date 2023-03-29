{ lib, generateOptions }:
{
  ##  Generic profiles
  options.profiles.desktop = (import ./desktopOptions.nix { inherit generateOptions lib; }) // {
    enable = generateOptions {
      inherit lib;
      default = false;
      description = "Enable graphical applications options in configuration";
    };
  };

  options.profiles.editors = {
    enable = generateOptions {
      inherit lib;
      default = true;
      description = "Enable text editors options in configuration";
    };
  };

  options.profiles.gaming = (import ./gamingOptions.nix { inherit generateOptions lib; }) // {
    enable = generateOptions {
      inherit lib;
      default = false;
      description = "Enable gaming options in configuration";
    };
  };

  options.profiles.languages = (import ./languagesOptions.nix { inherit generateOptions lib; }) // {
    enable = generateOptions {
      inherit lib;
      default = true;
      description = "Enable programming languages options in configuration";
    };
  };

  options.profiles.terminal = (import ./terminalOptions.nix { inherit generateOptions lib; }) // {
    enable = generateOptions {
      inherit lib;
      default = true;
      description = "Enable terminal options in configuration";
    };
  };

  options.profiles.system = (import ./systemOptions.nix) { inherit generateOptions lib; } // {
    enable = generateOptions {
      inherit lib;
      default = false;
      description = "Enable system specific options in configuration";
    };
  };

  ## Custom profiles for custom made dev env
  options.profiles.custom.doctoenv.enable = generateOptions {
    inherit lib;
    default = false;
    description = "Dev env containing all dependencies for Doctolib";
  };
}
