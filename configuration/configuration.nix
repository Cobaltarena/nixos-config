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
    ];

  boot.loader.grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      enableCryptodisk = true;
  };

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


  networking.hostName = "Camelot"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  networking.useDHCP = false;
  networking.networkmanager.enable = true;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  programs.dconf.enable = true;
  programs.light.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  users.users.root.initialHashedPassword = "";

  # Define a user account. Don't forget to set a password with ‘passwd’.
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

  # Add some extra stuff for a given user
  users.extraUsers.gawain = {
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
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

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # firmware update
  services.fwupd.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "21.11";
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  nixpkgs.config.allowUnfree = true;

}

