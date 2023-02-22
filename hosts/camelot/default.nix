# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./x/i3.nix
      ./x/sddm.nix
      ./home.nix
      #./users # TODO: directory containing all users
    ];

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 7;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/c7cb0f50-758f-4c2a-98e9-09feb3e639a9";
      preLVM = true;
    };
  };
  boot.supportedFilesystems = [
    "btrfs"
    "ext2"
    "ext3"
    "ext4"
    "exfat"
    "f2fs"
    "fat8"
    "fat16"
    "fat32"
    "ntfs"
    "xfs"
    # "zfs"
  ];
  boot.extraModulePackages = [ pkgs.bcc ];

  boot.kernelParams = [
    "acpi_backlight=vendor"
    "button.lid_init_state=open"
  ];

  nix = {
    package = pkgs.nixUnstable;
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
      dates = "monthly";
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

  time.timeZone = "Europe/Paris";

  networking = {
    hostName = "camelot"; # Define your hostname.
    networkmanager.enable = true;
    extraHosts = ''
       127.0.0.1 gitea droneci
    '';
  };

  programs.dconf.enable = true;
  programs.light.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  users.users.root.initialHashedPassword = "";

  users.users.gawain = {
    isNormalUser = true;
    home = "/home/gawain";
    group = "gawain";
    extraGroups = [
      "docker"
      "networkmanager"
      "video"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [
    zlib
    bcc
    cron
    git
    libsForQt5.qt5.qtgraphicaleffects
    sddm
    vim
    wget
  ];

  services.logind = {
    lidSwitch = "suspend";
  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "@reboot root rtcwake -m mem -s 2"
    ];
  };

  environment.pathsToLink = [ "/share/zsh" ];

  virtualisation.docker.enable = true;
  # virtualisation.docker.enableOnBoot = true;
  virtualisation.docker.liveRestore = false;
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # users.extraGroups.vboxusers.members = [ "gawain" ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # firmware update
  services.fwupd.enable = true;
  documentation.dev.enable = true;

  services.printing.browsing = true;
  services.printing.drivers = with pkgs; [ gutenprint canon-cups-ufr2 cups-filters ];
  services.printing.browsedConf = ''
      BrowseDNSSDSubTypes _cups,_print
      BrowseLocalProtocols all
      BrowseRemoteProtocols all
      CreateIPPPrinterQueues All

      BrowseProtocols all
    '';
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish.addresses = true;
    publish.domain = true;
    publish.enable = true;
    publish.userServices = true;
    publish.workstation = true;
    extraServiceFiles.ssh = "${pkgs.avahi}/etc/avahi/services/ssh.service";
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
}

