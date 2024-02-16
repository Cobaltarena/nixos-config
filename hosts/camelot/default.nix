# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./x/i3.nix
      ./x/sddm.nix
      ./home.nix
      #./users # TODO: directory containing all users
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
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
  boot.initrd.kernelModules = [ "dm-snapshot" "amdgpu"];
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
    "video=DP-1:1920x1080@144"
    "clearcpuid=514"
  ];
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

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
        "https://cache.nixos.org"
        "https://nixpkgs-wayland.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
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
    '';
  };

  programs.dconf.enable = true;
  programs.light.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  users.users.root.initialHashedPassword = "";

  users.groups.gawain = {};
  users.users.gawain = {
    isNormalUser = true;
    home = "/home/gawain";
    group = "gawain";
    extraGroups = [
      "docker"
      "input"
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

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    zlib
    bcc
    cron
    git
    libsForQt5.qt5.qtgraphicaleffects
    sddm
    vim
    wget

    # yubikey authenticator
    pkgs.pcsclite
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

  # GUI file explorer options
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  services.printing = {
    enable = true;
    browsing = true;
    drivers = with pkgs; [ hplipWithPlugin hplip];
    browsedConf = ''
    BrowseDNSSDSubTypes _cups,_print
    BrowseLocalProtocols all
    BrowseRemoteProtocols all
    CreateIPPPrinterQueues All

    BrowseProtocols all
  '';
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
    publish.addresses = true;
    publish.domain = true;
    publish.enable = true;
    publish.userServices = true;
    publish.workstation = true;
    extraServiceFiles.ssh = "${pkgs.avahi}/etc/avahi/services/ssh.service";
  };

  services.pcscd.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # vulkan driver
  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
  ];
}

