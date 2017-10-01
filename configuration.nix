# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "NixViAldru"; # Define your hostname.
    networkmanager.enable = true;
    networkmanager.insertNameservers = [ "8.8.8.8" "8.8.4.4" ];
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget git htop curl pstree lsof gawk ntfs3g nix-repl mkpasswd
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services = {
    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable the KDE Desktop Environment.
    xserver = {
      enable = true;
      xkbOptions = "eurosign:e";
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      layout = "us";
    };
    
    # Disable nscd if this is the cause of the page-loading problems
    # nscd.enable = false;
    
    redshift.enable = true;
    redshift.latitude = "53.0";
    redshift.longitude = "6.3";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    extraUsers = {
      guest = {
        isNormalUser = true;
        uid = 1000;
      };
      daniel = {
        isNormalUser = true;
        uid = 2000;
        createHome = true;
        extraGroups = [ "wheel" "networkmanager"];
        home = "/home/daniel";
        hashedPassword = import ./password_daniel.nix;
      };
    };
  };


  # Programs
  programs = {
    vim.defaultEditor = true;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
