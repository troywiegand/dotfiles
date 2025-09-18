# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../system.nix

      ../modules/bluetooth.nix
      ../modules/podman.nix
      ../modules/gaming.nix
      ../modules/printing.nix
      ../modules/services/boardgameday.nix
      ../modules/services/excalidraw.nix
      ../modules/services/home-assistant.nix
      ../modules/services/immich.nix
      ../modules/services/jellyfin-baremetal.nix
      ../modules/services/minecraft.nix
      ../modules/services/paperless.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "orzhov"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  services.cloudflared.enable = true;

  #Seemed to Crash System
  #services.hardware.openrgb.enable = true;

  environment.systemPackages = with pkgs; [ lact ];
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];


  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  #Enable Cinnamon

  #services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.desktopManager.cinnamon.enable = true;

  # Move CUPS to module
  services.printing.enable = true;

  # Enable sound with pipewire.
  # services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.troy = {
    packages = with pkgs; [
      prismlauncher
    ];
  };
  
  # Install firefox.
  programs.firefox.enable = true;

  fileSystems = {
    "/mnt/thrull" = {
     device = "/dev/sda1";
     fsType = "ext4";
    };
  };

  # Enable the OpenSSH daemon.
  # Modify the Default Port
  services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
