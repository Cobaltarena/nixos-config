# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

rec {
  imports =
    [
      ./home.nix
    ];

  homebrew = {
    brewPrefix = "/opt/homebrew/bin/";
    enable = true;
    onActivation.autoUpdate = true;
    # updates homebrew packages on activation,
    # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
    onActivation.upgrade = true;
    brews = [
      "llvm"
      "openssl@1.1"
    ];
    casks = [
      "alfred"
      "docker"
      "google-chrome"
      "iterm2"
      "logseq"
      "postico"
      "rectangle"
      "slack"
      "visual-studio-code"
    ];
  };

  nix = {
    package = pkgs.nixUnstable;
    useDaemon = true;
    gc = {
      user = "root"; # TODO ?
      automatic = true;
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
      warn-dirty = false;
      substituters = [
        "https://nix-community.cachix.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = [
      "nixpkgs=/etc/nix/channels/nixpkgs"
      "home-manager=/etc/nix/channels/home-manager"
    ];
  };
  environment.etc = {
    "nix/channels/nixpkgs".source = inputs.nixpkgs.outPath;
    "nix/channels/home-manager".source = inputs.home-manager.outPath;
  };
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


  time.timeZone = "Europe/Paris";

  users.users.thomas = {
    # isNormalUser = true;
    home = "/Users/thomas";
    # group = "thomas";
    # extraGroups = [
    #   "docker"
    #   "networkmanager"
    #   "video"
    #   "wheel"
    # ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    zlib
    cron
    git
    vim
    wget
  ];

  environment.pathsToLink = [ "/share/zsh" ];

  # virtualisation.docker.enable = true;
  # virtualisation.docker.liveRestore = false;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.nix-daemon = {
    enable = true;
    # package = pkgs.nixFlakes;
  };
  # documentation.dev.enable = true;

  system.defaults.dock.autohide = true;
  system.activationScripts.applications.text = pkgs.lib.mkForce (
    ''
      echo "[CUSTOM][darwin.nix] setting up ~/Applications..." >&2
      rm -rf ~/Applications/Nix\ Apps
      mkdir -p ~/Applications/Nix\ Apps
      for app in $(find ${config.system.build.applications}/Applications -maxdepth 1 -type l); do
        src="$(/usr/bin/stat -f%Y "$app")"
        cp -r "$src" ~/Applications/Nix\ Apps
      done
    ''
  );
}

