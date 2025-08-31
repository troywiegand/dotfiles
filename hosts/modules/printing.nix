{ config, pkgs, ... }:
{
  # https://nixos.wiki/wiki/Printing

  environment.systemPackages = with pkgs; [
    hplip
  ];

  services.printing.enable = true; # enables printing support via the CUPS daemon
}
