# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./x/i3.nix
      ./x/sddm.nix
      ./home.nix
      #./users # TODO: directory containing all users
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices = {
       root = {
	       device = "/dev/disk/by-uuid/c7cb0f50-758f-4c2a-98e9-09feb3e639a9";
         preLVM = true;
       };
  };

  boot.kernelParams = [
    "acpi_backlight=vendor"
    "button.lid_init_state=open"
  ];


  networking.hostName = "camelot"; # Define your hostname.

  time.timeZone = "Europe/Paris";

  networking.useDHCP = false;
  networking.networkmanager.enable = true;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  programs.dconf.enable = true;
  programs.light.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  users.users.root.initialHashedPassword = "";

  users.users.gawain = {
    isNormalUser = true;
    home = "/home/gawain";
    extraGroups = [
      "docker"
      "networkmanager"
      "video"
      "wheel"
    ];
  };

  users.extraUsers.gawain = {
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    cron
    git
    libsForQt515.qtgraphicaleffects
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
  users.extraGroups.vboxusers.members = [ "gawain" ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # firmware update
  services.fwupd.enable = true;

  system.stateVersion = "21.11";
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfree = true;

}

