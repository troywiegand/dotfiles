{ pkgs, inputs, ... }:
{
  # Base system config for all NixOS configurations

  # TODO: consider removing
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  services = {
    tailscale.enable = true;
    mullvad-vpn = {
     enable = true;
     package = pkgs.mullvad-vpn; # includes GUI
    };
    flatpak.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  programs.nh = {
    enable = true;
    flake = "/home/troy/repos/dotfiles";
  };
  programs.zsh.enable = true;
  users.users.troy = {
    isNormalUser = true;
    description = "troy";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    neovim 
    git 
    home-manager
    rxvt-unicode
  ];
  
  # Locale settings
  time.timeZone = "America/Indiana/Indianapolis";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
